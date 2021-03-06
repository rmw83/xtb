! This file is part of xtb.
!
! Copyright (C) 2019-2020 Sebastian Ehlert
!
! xtb is free software: you can redistribute it and/or modify it under
! the terms of the GNU Lesser General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! xtb is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU Lesser General Public License for more details.
!
! You should have received a copy of the GNU Lesser General Public License
! along with xtb.  If not, see <https://www.gnu.org/licenses/>.

!> 
module xtb_main_defaults
   use xtb_mctc_accuracy, only : wp
   use xtb_embedding, only : init_pcem
   use xtb_type_calculator, only : TCalculator
   use xtb_type_environment, only : TEnvironment
   use xtb_type_molecule, only : TMolecule
   use xtb_setparam, only : temp_md, gfn_method, ngrida, solvent, opt_engine, &
      & p_engine_lbfgs, p_engine_rf, silent
   use xtb_solv_gbobc, only : lgbsa, init_gbsa
   implicit none
   private

   public :: initDefaults


contains


subroutine initDefaults(env, calc, mol, gsolvstate)

   type(TEnvironment), intent(inout) :: env
   class(TCalculator), intent(in) :: calc
   type(TMolecule), intent(in) :: mol
   integer, intent(in) :: gsolvstate

   if (.not.allocated(opt_engine)) then
      if (mol%n > 500) then
         opt_engine = p_engine_lbfgs
      else
         opt_engine = p_engine_rf
      end if
   end if

   if (lgbsa) then
      call init_gbsa(env%unit, solvent, gsolvstate, temp_md, gfn_method, ngrida, &
         & .not.silent)
   end if

   ! initialize PC embedding (set default file names and stuff)
   call init_pcem

end subroutine initDefaults


end module xtb_main_defaults
