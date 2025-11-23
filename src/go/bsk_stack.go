! bsk_stack.f90
module bsk_mod
  implicit none
  private
  public :: BSKType, bsk_new, bsk_push, bsk_pop, bsk_update, bsk_size

  type :: Node
    character(len=1) :: color
    integer :: value
  end type Node

  type :: BSKType
    type(Node), allocatable :: data(:)
    real :: whiteRatio = 0.3
    real :: blueRatio = 0.4
  end type BSKType

contains

  function bsk_new() result(s)
    type(BSKType) :: s
    allocate(s%data(0))
  end function

  subroutine bsk_push(s, v)
    type(BSKType), intent(inout) :: s
    integer, intent(in) :: v
    integer :: n
    n = size(s%data)
    call move_alloc(s%data, s%data, stat=)
    s%data = [ (Node('W', v)) , s%data ]
  end subroutine

  integer function bsk_pop(s)
    type(BSKType), intent(inout) :: s
    integer :: n, w, b, i
    n = size(s%data)
    if (n==0) then
      stop "empty"
    end if
    w = int(n * s%whiteRatio)
    b = int(n * (s%whiteRatio + s%blueRatio))
    do i=1,w
      if (s%data(i)%color == 'W' .or. s%data(i)%color == 'B') then
        bsk_pop = s%data(i)%value
        s%data = [ s%data(1:i-1), s%data(i+1:)/ ]
        return
      end if
    end do
    do i=w+1,b
      if (s%data(i)%color == 'B') then
        bsk_pop = s%data(i)%value
        s%data = [ s%data(1:i-1), s%data(i+1:)/ ]
        return
      end if
    end do
    stop "Red zone locked"
  end function

  subroutine bsk_update(s)
    type(BSKType), intent(inout) :: s
    integer :: n, w, b, i
    n = size(s%data)
    w = int(n * s%whiteRatio)
    b = int(n * (s%whiteRatio + s%blueRatio))
    do i=1,n
      if (i <= w) s%data(i)%color = 'W'
      else if (i <= b) s%data(i)%color = 'B'
      else s%data(i)%color = 'R'
    end do
  end subroutine

  integer function bsk_size(s)
    type(BSKType), intent(in) :: s
    bsk_size = size(s%data)
  end function

end module
