module type_ideal_gas
#include <messenger.h>
    use mod_kinds,          only: rk
    use mod_constants,      only: HALF, ONE
    use mod_fluid,          only: Rgas, gam
    use type_model,         only: model_t
    use type_chidg_worker,  only: chidg_worker_t
    use DNAD_D
    implicit none


    


    !>  An equation of state model for an ideal gas.
    !!
    !!  Model Fields:
    !!      - Pressure
    !!      - Temperature
    !!
    !!  @author Nathan A. Wukie
    !!  @date   12/1/2016
    !!
    !---------------------------------------------------------------------------------------
    type, extends(model_t)  :: ideal_gas_t

    contains

        procedure   :: init
        procedure   :: compute

    end type ideal_gas_t
    !***************************************************************************************





contains




    !>  Initialize the model with a name and the model fields it is contributing to.
    !!
    !!  @author Nathan A. Wukie
    !!  @date   12/1/2016
    !!
    !---------------------------------------------------------------------------------------
    subroutine init(self)   
        class(ideal_gas_t), intent(inout)   :: self

        call self%set_name('Ideal Gas')
        call self%set_dependency('f(Q-)')

        call self%add_model_field('Pressure')
        call self%add_model_field('Temperature')


    end subroutine init
    !***************************************************************************************






    !>  Routine for computing the Pressure and Temperature.
    !!
    !!  @author Nathan A. Wukie
    !!  @date   12/1/2016
    !!
    !--------------------------------------------------------------------------------------
    subroutine compute(self,worker)
        class(ideal_gas_t),     intent(in)      :: self
        type(chidg_worker_t),   intent(inout)   :: worker

        type(AD_D), dimension(:),   allocatable :: &
            density, mom1, mom2, mom3, energy, pressure, temperature


        !
        ! Interpolate solution to quadrature nodes
        !
        density = worker%get_primary_field_value_ale_general('Density')
        mom1    = worker%get_primary_field_value_ale_general('Momentum-1')
        mom2    = worker%get_primary_field_value_ale_general('Momentum-2')
        mom3    = worker%get_primary_field_value_ale_general('Momentum-3')
        energy  = worker%get_primary_field_value_ale_general('Energy')


        !
        ! Account for cylindrical. Get tangential momentum from angular momentum.
        !
        if (worker%coordinate_system() == 'Cylindrical') then
            mom2 = mom2 / worker%coordinate('1')
        else if (worker%coordinate_system() == 'Cartesian') then

        else
            call chidg_signal(FATAL,"inlet, bad coordinate system")
        end if


        pressure = (gam-ONE)*(energy - HALF*( (mom1*mom1) + (mom2*mom2) + (mom3*mom3) )/density )
        temperature = pressure/(density*Rgas)



        call worker%store_model_field('Pressure',    'value', pressure)
        call worker%store_model_field('Temperature', 'value', temperature)


    end subroutine compute
    !***************************************************************************************









end module type_ideal_gas
