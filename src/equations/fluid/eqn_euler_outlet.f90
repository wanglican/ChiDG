module eqn_euler_outlet
#include <messenger.h>
    use type_equation_set,          only: equation_set_t
    use type_equation_builder,      only: equation_builder_t
    use type_solverdata,            only: solverdata_t
    use type_fluid_pseudo_timestep, only: fluid_pseudo_timestep_t
    implicit none


    !>
    !!
    !!
    !!
    !--------------------------------------------------------------------------------------------
    type, public, extends(equation_builder_t) :: euler_outlet

    contains

        procedure   :: init
        procedure   :: build

    end type euler_outlet
    !********************************************************************************************




contains


    !>
    !!
    !!  @author Nathan A. Wukie (AFRL)
    !!  @date   8/30/2016
    !!
    !---------------------------------------------------------------------------------------------
    subroutine init(self)
        class(euler_outlet),   intent(inout)  :: self

        call self%set_name('Euler Outlet')

    end subroutine init
    !*********************************************************************************************



    !>
    !!
    !!  @author Nathan A. Wukie (AFRL)
    !!  @date   8/30/2016
    !!
    !!
    !---------------------------------------------------------------------------------------------
    function build(self,blueprint) result(euler_outlet_eqns)
        class(euler_outlet),    intent(in)  :: self
        character(*),           intent(in)  :: blueprint

        type(equation_set_t)            :: euler_outlet_eqns
        type(fluid_pseudo_timestep_t)   :: fluid_pseudo_time

        !
        ! Set equation set name
        !
        call euler_outlet_eqns%set_name('Euler Outlet')


        call euler_outlet_eqns%add_operator('Euler Volume Flux')
        call euler_outlet_eqns%add_operator('Euler Boundary Average Flux')
        call euler_outlet_eqns%add_operator('Euler Roe Flux')
        call euler_outlet_eqns%add_operator('Euler BC Flux')
        call euler_outlet_eqns%add_operator('Euler Volume Cylindrical Source')


        call euler_outlet_eqns%add_operator('Graddemo P BC Operator')
        call euler_outlet_eqns%add_operator('Graddemo P Boundary Average Operator')
        call euler_outlet_eqns%add_operator('Graddemo P Volume Operator')
!        call euler_outlet_eqns%add_operator('Graddemo P Volume Source')


        call euler_outlet_eqns%add_model('Pressure Gradient')
        call euler_outlet_eqns%add_model('Temperature Gradient')
        call euler_outlet_eqns%add_model('Ideal Gas')
!        call euler_eqns%add_pseudo_timestep(fluid_pseudo_time)



    end function build
    !**********************************************************************************************

















end module eqn_euler_outlet