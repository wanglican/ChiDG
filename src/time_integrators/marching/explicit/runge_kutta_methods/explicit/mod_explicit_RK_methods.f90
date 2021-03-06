module mod_define_explicit_RK_methods
! Module containing subroutines and functions defining various explicit Runge-Kutta methods
    use mod_kinds,      only: rk,ik
    use mod_constants,  only: ZERO,ONE,TWO,THREE,EIGHTH,SIXTH,FOURTH,THIRD,HALF,TWO_THR
    implicit none
    
    
   
    !! 
    !! The equation to be solved here is
    !!
    !! \f$ \frac{\partial Q}{\partial t} + R(Q) = 0 \f$
    !!
    !! The discretization is given as
    !!
    !! \f$ Q^{n + 1} = Q^{n} + \Delta Q \f$
    !!
    !! where
    !!
    !! \f$ \Delta Q = \sum_{i = 1}^{s} b_{i} \Delta Q_{i} \f$
    !!
    !! with \f$ s \f$ being the number of stages in the method and
    !!
    !! \f$ \Delta Q_{i} = -\Delta t M^{-1} R(Q^{n} + \sum_{j = 1}^{i - 1} a_{ij} \Delta Q_{j} \f$
    !!
    !! Butcher tableau notation has been followed here
    !! 
contains



    !> Define Runge's method (2nd order method with two stages)
    !!
    !! @author Mayank Sharma
    !! @date   1/17/2017
    !!
    !! @param[out]  nstage - Number of stages in the present method
    !! @param[out]  a      - Array of coefficients for calculating stagewise updates
    !! @param[out]  b      - Array of coefficients for summing stagewise updates to get final update
    !!
    !---------------------------------------------------------------------------------------------------
    subroutine runge_2nd_order(nstage,a,b)
        integer(ik),            intent(inout)        :: nstage
        real(rk),   allocatable,intent(inout)        :: a(:,:)
        real(rk),   allocatable,intent(inout)        :: b(:)


        !
        ! Set number of stages
        !
        nstage = 2

        if (allocated(a) .and. allocated(b)) deallocate(a,b)
        allocate(a(nstage,nstage),b(nstage))

        !
        ! a is a lower triangular matrix
        !
        a      = ZERO
        a(2,1) = HALF


        b = [ZERO, ONE]


    end subroutine runge_2nd_order
    !***************************************************************************************************   



    !> Define Heun's method (2nd order method with two stages)
    !!
    !! @author Mayank Sharma
    !! @date   1/17/2017
    !!
    !! @param[out]  nstage - Number of stages in the present method
    !! @param[out]  a      - Array of coefficients for calculating stagewise updates
    !! @param[out]  b      - Array of coefficients for summing stagewise updates to get final update
    !!
    !---------------------------------------------------------------------------------------------------
    subroutine heun_2nd_order(nstage,a,b)
        integer(ik),            intent(inout)       :: nstage
        real(rk),   allocatable,intent(inout)       :: a(:,:)
        real(rk),   allocatable,intent(inout)       :: b(:)


        !
        ! Set number of stages
        !
        nstage = 2

        if (allocated(a) .and. allocated(b)) deallocate(a,b)
        allocate(a(nstage,nstage),b(nstage))

        !
        ! a is a lower triangular matrix
        !
        a      = ZERO
        a(2,1) = ONE 


        b = [HALF,HALF]


    end subroutine heun_2nd_order
    !***************************************************************************************************   



    !> Define Ralston's method (2nd order method with two stages)
    !!
    !! @author Mayank Sharma
    !! @date   1/17/2017
    !!
    !! @param[out]  nstage - Number of stages in the present method
    !! @param[out]  a      - Array of coefficients for calculating stagewise updates
    !! @param[out]  b      - Array of coefficients for summing stagewise updates to get final update
    !!
    !---------------------------------------------------------------------------------------------------
    subroutine ralston_2nd_order(nstage,a,b)
        integer(ik),            intent(inout)       :: nstage
        real(rk),   allocatable,intent(inout)       :: a(:,:)
        real(rk),   allocatable,intent(inout)       :: b(:)


        !
        ! Set number of stages
        !
        nstage = 2

        if (allocated(a) .and. allocated(b)) deallocate(a,b)
        allocate(a(nstage,nstage),b(nstage))

        !
        ! a is a lower triangular matrix
        !
        a      = ZERO
        a(2,1) = TWO_THR


        b = [FOURTH,THREE*FOURTH]


    end subroutine ralston_2nd_order
    !***************************************************************************************************   



    !> Define Kutta's method (3rd order method with three stages)
    !!
    !! @author Mayank Sharma
    !! @date   1/17/2017
    !!
    !! @param[out]  nstage - Number of stages in the present method
    !! @param[out]  a      - Array of coefficients for calculating stagewise updates
    !! @param[out]  b      - Array of coefficients for summing stagewise updates to get final update
    !!
    !---------------------------------------------------------------------------------------------------
    subroutine kutta_3rd_order(nstage,a,b)
        integer(ik),            intent(inout)       :: nstage
        real(rk),   allocatable,intent(inout)       :: a(:,:)
        real(rk),   allocatable,intent(inout)       :: b(:)


        !
        ! Set number of stages
        !
        nstage = 3

        if (allocated(a) .and. allocated(b)) deallocate(a,b)
        allocate(a(nstage,nstage),b(nstage))

        !
        ! a is a lower triangular matrix
        !
        a      = ZERO
        a(2,1) = HALF; a(3,1) = -ONE; a(3,2) = TWO 


        b = [SIXTH,TWO_THR,SIXTH]


    end subroutine kutta_3rd_order
    !***************************************************************************************************   



    !> Define the Runge-Kutta  method (4th order method with four stages)
    !!
    !! @author Mayank Sharma
    !! @date   1/17/2017
    !!
    !! @param[out]  nstage - Number of stages in the present method
    !! @param[out]  a      - Array of coefficients for calculating stagewise updates
    !! @param[out]  b      - Array of coefficients for summing stagewise updates to get final update
    !!
    !---------------------------------------------------------------------------------------------------
    subroutine runge_kutta_4th_order(nstage,a,b)
        integer(ik),            intent(inout)       :: nstage
        real(rk),   allocatable,intent(inout)       :: a(:,:)
        real(rk),   allocatable,intent(inout)       :: b(:)


        !
        ! Set number of stages
        !
        nstage = 4

        if (allocated(a) .and. allocated(b)) deallocate(a,b)
        allocate(a(nstage,nstage),b(nstage))

        !
        ! a is a lower triangular matrix
        !
        a      = ZERO
        a(2,1) = HALF; a(3,2) = HALF; a(4,3) = ONE


        b = [SIXTH,THIRD,THIRD,SIXTH]


    end subroutine runge_kutta_4th_order
    !***************************************************************************************************   



    !> Define the 3/8-rule method (4th order method with four stages)
    !!
    !! @author Mayank Sharma
    !! @date   1/17/2017
    !!
    !! @param[out]  nstage - Number of stages in the present method
    !! @param[out]  a      - Array of coefficients for calculating stagewise updates
    !! @param[out]  b      - Array of coefficients for summing stagewise updates to get final update
    !!
    !---------------------------------------------------------------------------------------------------
    subroutine three_eighth_4th_order(nstage,a,b)
        integer(ik),            intent(inout)       :: nstage
        real(rk),   allocatable,intent(inout)       :: a(:,:)
        real(rk),   allocatable,intent(inout)       :: b(:)


        !
        ! Set number of stages
        !
        nstage = 4

        if (allocated(a) .and. allocated(b)) deallocate(a,b)
        allocate(a(nstage,nstage),b(nstage))

        !
        ! a is a lower triangular matrix
        !
        a      = ZERO
        a(2,1) = THIRD
        a(3,1) = -THIRD; a(3,2) = ONE
        a(4,1) = ONE; a(4,2) = -ONE; a(4,3) = ONE 


        b = [EIGHTH,THREE*EIGHTH,THREE*EIGHTH,EIGHTH]


    end subroutine three_eighth_4th_order
    !***************************************************************************************************   



    !> Select explicit Runge-Kutta method based on input 
    !!
    !! @author Mayank Sharma
    !! @date   1/23/2017
    !!
    !! @param[in]   time_scheme - String denoting the method to be used from user input
    !! @param[out]  nstage      - Number of stages in the selected method
    !! @param[out]  a           - Array of coefficients for calculating stagewise updates
    !! @param[out]  b           - Array of coefficients for summing stagewise updates to get final update
    !!
    !---------------------------------------------------------------------------------------------------
    subroutine method_selector(time_scheme,nstage,a,b)
        character(len = :), allocatable, intent(in)     :: time_scheme
        integer(ik),                     intent(inout)  :: nstage
        real(rk),           allocatable, intent(inout)  :: a(:,:)
        real(rk),           allocatable, intent(inout)  :: b(:)


        select case(time_scheme)
            
            case('Second Order Runge-Kutta', 'Explicit Midpoint', 'Second Order RK')
                call runge_2nd_order(nstage,a,b)

            case('Modified Euler', 'Second Order Heun Method')
                call heun_2nd_order(nstage,a,b)

            case('Ralston Method', 'Second Order Ralston Method')
                call ralston_2nd_order(nstage,a,b)

            case('Third Order Runge-Kutta', 'Third Order Kutta', 'Third Order RK')
                call kutta_3rd_order(nstage,a,b)

            case('Runge-Kutta Method', 'Fourth Runge-Kutta Method', 'Fourth Order RK Method', 'RK4')
                call runge_kutta_4th_order(nstage,a,b)

            case('Three-Eighth Rule', 'Fourth Order Kutta')
                call three_eighth_4th_order(nstage,a,b)

        end select


    end subroutine method_selector
    !***************************************************************************************************   

        


















 
end module mod_define_explicit_RK_methods
