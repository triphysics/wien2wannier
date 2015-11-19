!!! wien2wannier/SRC_w2w/gaunt2.f
!!!
!!! $Id: gaunt2.f 385 2015-06-01 13:08:18Z assmann $

      SUBROUTINE GAUNT2
!
      use assleg, only: YR, N, init_assleg
      IMPLICIT NONE
!
!     ..................................................................
!
!        set YR needed in function GAUNT1
!
!     ..................................................................
!
!      INTEGER            MAXDIM, N
!      PARAMETER          (MAXDIM = 81, N = 6)
      DOUBLE PRECISION   ZERO, SNULL, ONE
      PARAMETER          (ZERO = 0.0D+0, SNULL = 1.0D-10, ONE = 1.0D+0)
!
!        Locals
!
      INTEGER            I, IDWN, IX, K, L, L1, L2, LM, LM2, LOMAX, M
      INTEGER            M1
      DOUBLE PRECISION   C1L, C2L, CD, CSR, CTH, CYP, FACTOR, FPI
      DOUBLE PRECISION   RF, SGNM, STH, TCTH
      DOUBLE PRECISION   X(N), P(10,10)
!
!        Intrinsic Functions
!
      INTRINSIC          ABS, SQRT
!
!        Data statements
!
      DATA X /0.12523340851147D+0, 0.36783149899818D+0, &
              0.58731795428662D+0, 0.76990267419431D+0, &
              0.90411725637048D+0, 0.98156063424672D+0/
!
      call init_assleg

      FPI = 16.0D+0*ATAN(1.0D+0)
      FACTOR = FPI**(1.0D+0/3.0D+0)
      LOMAX = 8
!
      DO 50 K = 1, N
         CTH = X(K)
         STH = SQRT(ONE-CTH*CTH)
         RF = ONE/SQRT(FPI)
         YR(K,1) = RF*FACTOR
         I = 1
         P(1,1) = ONE
         P(2,1) = CTH
         C2L = CTH
         TCTH = CTH + CTH
         L1 = 2
         L = 1
   10    CONTINUE
         M = 1
         I = I + L
         IDWN = I + 2
         M1 = 2
         L2 = L
         L = L1
         L1 = L + 1
         LM = L2
         LM2 = L
         CD = ONE
         C2L = C2L + TCTH
         SGNM = ONE
   20    CONTINUE
!
!        recurse upward in L
!
         P(L1,M) = (C2L*P(L,M)-LM*P(L2,M))/LM2
         C1L = (LM+1)*CTH
         P(L,M1) = ZERO
!
!        recurse upward in M
!
         IF (ABS(STH) .GE. SNULL) P(L,M1) = (C1L*P(L,M)-LM2*P(L1,M))/STH
   30    CONTINUE
         I = I + 1
         IDWN = IDWN - 1
         CSR = SQRT((2*L-ONE)/(FPI*CD))
         CYP = SGNM*CSR*P(L,M)
         YR(K,I) = CYP*FACTOR
         IX = I - (L*L - L + 1)
         IF (IDWN .NE. I) YR(K,IDWN) = FACTOR*CYP*(-1)**IX
         M = M1
         M1 = M + 1
         LM2 = LM2 - 1
         LM = LM + 1
         CD = CD*LM*LM2
         SGNM = -SGNM
         IF (M - L < 0) goto 20
         IF (M - L ==0) goto 30
         IF (L .LE. LOMAX) GOTO 10
   50 CONTINUE
!
      RETURN
!
!        End of 'GAUNT2'
!
      END


!!/---
!! Local Variables:
!! mode: f90
!! End:
!!\---
!!
!! Time-stamp: <2015-05-23 19:58:48 elias>
