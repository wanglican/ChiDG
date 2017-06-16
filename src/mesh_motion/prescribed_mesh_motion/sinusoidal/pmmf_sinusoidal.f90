module pmmf_sinusoidal
#include <messenger.h>
    use mod_kinds,      only: rk,ik
    use mod_constants,  only: ZERO, HALF, ONE, TWO, THREE, FIVE, EIGHT, PI
    use type_point,     only: point_t
    use type_prescribed_mesh_motion_function,  only: prescribed_mesh_motion_function_t
    implicit none
    private








    !>  Sinusoidal mesh motion. 
    !!
    !!  @author Eric Wolf
    !!  @date   3/15/2017 
    !!
    !!
    !-------------------------------------------------------------------------------
    type, extends(prescribed_mesh_motion_function_t), public :: sinusoidal_pmmf
        private

        
    contains

        procedure   :: init
        procedure   :: compute_pos
        procedure   :: compute_vel

    end type sinusoidal_pmmf
    !********************************************************************************



contains




    !>
    !!
    !!  @author Eric Wolf
    !!  @date   3/15/2017 
    !!
    !-------------------------------------------------------------------------
    subroutine init(self)
        class(sinusoidal_pmmf),  intent(inout)  :: self

        !
        ! Set function name
        !
        call self%set_name("sinusoidal")


        !
        ! Set function options to default settings
        !
        call self%add_option('L_X',1._rk)
        call self%add_option('L_Y',1._rk)
        call self%add_option('L_Z',1._rk)
        call self%add_option('GRID_MODE_X',1._rk)
        call self%add_option('GRID_MODE_Y',1._rk)
        call self%add_option('GRID_MODE_Z',1._rk)
        call self%add_option('GRID_FREQ_X',1._rk)
        call self%add_option('GRID_FREQ_Y',1._rk)
        call self%add_option('GRID_FREQ_Z',1._rk)
        call self%add_option('GRID_AMP_X',1._rk)
        call self%add_option('GRID_AMP_Y',1._rk)
        call self%add_option('GRID_AMP_Z',1._rk)


    end subroutine init
    !*************************************************************************



    !>
    !!
    !!  @author Eric Wolf
    !!  @date   3/15/2017 
    !!
    !!
    !-----------------------------------------------------------------------------------------
    impure  elemental function compute_pos(self,time,coord) result(val)
        class(sinusoidal_pmmf),     intent(inout)  :: self
        real(rk),                       intent(in)  :: time
        type(point_t),                  intent(in)  :: coord

        integer(ik)                                 :: ivar
        type(point_t)                                    :: val

        real(rk)                                    :: L_X, L_Y, L_Z, &
                                                        GRID_MODE_X, GRID_MODE_Y, GRID_MODE_Z, &
                                                        GRID_FREQ_X, GRID_FREQ_Y, GRID_FREQ_Z, &
                                                        GRID_AMP_X, GRID_AMP_Y, GRID_AMP_Z
        L_X = self%get_option_value('L_X')
        L_Y = self%get_option_value('L_Y')
        L_Z = self%get_option_value('L_Z')
        GRID_MODE_X = self%get_option_value('GRID_MODE_X')
        GRID_MODE_Y = self%get_option_value('GRID_MODE_Y')
        GRID_MODE_Z = self%get_option_value('GRID_MODE_Z')
        GRID_FREQ_X = self%get_option_value('GRID_FREQ_X')
        GRID_FREQ_Y = self%get_option_value('GRID_FREQ_Y')
        GRID_FREQ_Z = self%get_option_value('GRID_FREQ_Z')
        GRID_AMP_X = self%get_option_value('GRID_AMP_X')
        GRID_AMP_Y = self%get_option_value('GRID_AMP_Y')
        GRID_AMP_Z = self%get_option_value('GRID_AMP_Z')
        
        val%c1_ = coord%c1_ + &
            GRID_AMP_X* &
            sin(GRID_MODE_X*TWO*PI*coord%c1_/L_X)* &
            sin(GRID_MODE_Y*TWO*PI*coord%c2_/L_Y)* &
            sin(GRID_MODE_Z*TWO*PI*coord%c3_/L_Z)* &
            sin(GRID_FREQ_X*time)
        
        val%c2_ = coord%c2_ + &
            GRID_AMP_Y* &
            sin(GRID_MODE_X*TWO*PI*coord%c1_/L_X)* &
            sin(GRID_MODE_Y*TWO*PI*coord%c2_/L_Y)* &
            sin(GRID_MODE_Z*TWO*PI*coord%c3_/L_Z)* &
            sin(GRID_FREQ_Y*time)
        
        val%c3_ = coord%c3_ + &
            GRID_AMP_Z* &
            sin(GRID_MODE_X*TWO*PI*coord%c1_/L_X)* &
            sin(GRID_MODE_Y*TWO*PI*coord%c2_/L_Y)* &
            sin(GRID_MODE_Z*TWO*PI*coord%c3_/L_Z)* &
            sin(GRID_FREQ_Z*time)
        
    end function compute_pos
    !**********************************************************************************






    !>
    !!
    !!  @author Eric Wolf
    !!  @date   3/15/2017 
    !!
    !!
    !-----------------------------------------------------------------------------------------
    impure  elemental function compute_vel(self,time,coord) result(val)
        class(sinusoidal_pmmf),     intent(inout)  :: self
        real(rk),                       intent(in)  :: time
        type(point_t),                  intent(in)  :: coord

        integer(ik)                                 :: ivar
        type(point_t)                                   :: val
        real(rk)                                    :: L_X, L_Y, L_Z, &
                                                        GRID_MODE_X, GRID_MODE_Y, GRID_MODE_Z, &
                                                        GRID_FREQ_X, GRID_FREQ_Y, GRID_FREQ_Z, &
                                                        GRID_AMP_X, GRID_AMP_Y, GRID_AMP_Z
        L_X = self%get_option_value('L_X')
        L_Y = self%get_option_value('L_Y')
        L_Z = self%get_option_value('L_Z')
        GRID_MODE_X = self%get_option_value('GRID_MODE_X')
        GRID_MODE_Y = self%get_option_value('GRID_MODE_Y')
        GRID_MODE_Z = self%get_option_value('GRID_MODE_Z')
        GRID_FREQ_X = self%get_option_value('GRID_FREQ_X')
        GRID_FREQ_Y = self%get_option_value('GRID_FREQ_Y')
        GRID_FREQ_Z = self%get_option_value('GRID_FREQ_Z')
        GRID_AMP_X = self%get_option_value('GRID_AMP_X')
        GRID_AMP_Y = self%get_option_value('GRID_AMP_Y')
        GRID_AMP_Z = self%get_option_value('GRID_AMP_Z')
        
        val%c1_ =  &
            GRID_AMP_X* &
            sin(GRID_MODE_X*TWO*PI*coord%c1_/L_X)* &
            sin(GRID_MODE_Y*TWO*PI*coord%c2_/L_Y)* &
            sin(GRID_MODE_Z*TWO*PI*coord%c3_/L_Z)* &
            GRID_FREQ_X*cos(GRID_FREQ_X*time)
        
        val%c2_ =  &
            GRID_AMP_Y* &
            sin(GRID_MODE_X*TWO*PI*coord%c1_/L_X)* &
            sin(GRID_MODE_Y*TWO*PI*coord%c2_/L_Y)* &
            sin(GRID_MODE_Z*TWO*PI*coord%c3_/L_Z)* &
            GRID_FREQ_Y*cos(GRID_FREQ_Y*time)
        
        val%c3_ =  &
            GRID_AMP_Z* &
            sin(GRID_MODE_X*TWO*PI*coord%c1_/L_X)* &
            sin(GRID_MODE_Y*TWO*PI*coord%c2_/L_Y)* &
            sin(GRID_MODE_Z*TWO*PI*coord%c3_/L_Z)* &
            GRID_FREQ_Z*cos(GRID_FREQ_Z*time)
 
        
    end function compute_vel
    !**********************************************************************************


end module pmmf_sinusoidal