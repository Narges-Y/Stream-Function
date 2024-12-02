program Laplas_s
    implicit none
    integer:: i,j,iteration,j1,j2,j3,j4
    integer,parameter::n=101,m=201
    doubleprecision::x(n),y(m),si(n,m),si_old(n,m),l=1.0,h=2.0&
    ,dx,dy,error,resi,a1,b1,c1,d1,a2,b2,c2,d2,u(n,m),v(n,m),beta

    !making file
    open(10,file='output.plt')

    !inputs
    resi = 0.00001
    a1 = 0.2
    b1 = 0.3
    c1 = 0.7
    d1 = 0.5
    a2 = 0.4
    b2 = 0.5
    c2 = 0.2
    d2 = 0.1

    !grid generation
    dx = l/(n-1)
    dy = h/(m-1)
    beta = dx/dy
    do i=1,n
        x(i) = (i-1)*dx
    end do

    do j=1,m
        y(j) = (j-1)*dy
    end do


    j1 = 161
    j2 = 181
    j3 = 31
    j4 = 51


    !initial condition
    si(:,:) = 0.0

    !boundary conditions
    !si
    si(:,1) = 0.0
    si(:,m) = 100.0
    si(1,1:j1-1) = 0.0
    do j=j1,j2
        si(1,j) = (a1/3.0)*(y(j)**3.0)+(b1/2.0)*(y(j)**2.0)+c1*y(j)+d1
    end do
    si(1,j2+1:m) = 100.0
    si(n,1:j3-1) = 0.0
    do j=j3,j4
        si(n,j) = (a2/3.0)*(y(j)**3.0)+(b2/2.0)*(y(j)**2.0)+c2*y(j)+d2
    end do
    si(n,j4+1:m) = 100.0
    !velocity
    u(:,1) = 0.0
    u(:,m) = 0.0
    u(1,1:j1-1) = 0.0
    do j=j1,j2
        u(1,j) = a1*(y(j)**2.0)+b1*y(j)+c1
    end do
    u(1,j2+1:m) = 0.0
    u(n,1:j3-1) = 0.0
    do j=j3,j4
        u(n,j) = a2*(y(j)**2.0)+b2*y(j)+c2
    end do
    u(n,j4+1:m) = 0.0
    v(:,1) = 0.0
    v(:,m) = 0.0
    v(1,:) = 0.0
    v(n,:) = 0.0


    !solving problem
    iteration = 0
    do
        iteration = iteration+1
        error = 0.0
        si_old(:,:) = si(:,:)
        do j=2,m-1
            do i=2,n-1
                si(i,j) = (si(i-1,j)+si_old(i+1,j)+(beta**2.0)*(si(i,j-1)&
                +si_old(i,j+1)))/(2.0*(1.0+beta**2.0))
            end do
        end do

        do j=2,m-1
            do i=2,n-1
                error = max(error,abs(si(i,j)-si_old(i,j)))
            end do
        end do

        print *,iteration,error
        if(error<resi) exit


    end do

    !calculating velocity
    do j=2,m-1
        do i=2,n-1
            u(i,j) = (si(i,j+1)-si(i,j-1))/(2.0*dy)
            v(i,j) = -(si(i+1,j)-si(i-1,j))/(2.0*dx)
        end do
    end do

    !writing results
    write(10,*) 'variables=x,y,u,v zone i=',n,'j=',m
    do j=1,m
        do i=1,n
            write(10,*) x(i),y(j),u(i,j),v(i,j)
        end do
    end do



end program

