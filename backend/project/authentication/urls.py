from django.urls import path
from .views import (
    CustomUserList,
    CustomUserDetail,
    CustomUserRegister,
    LoginView,
    PasswordResetRequestView,
)
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
    TokenVerifyView,
    
)

urlpatterns = [
    
    path('login/', LoginView.as_view()),
    path('list/', CustomUserList.as_view()),
    path('list/<int:pk>/', CustomUserDetail.as_view()),
    path('register/', CustomUserRegister.as_view()),
    path('reset_password/', PasswordResetRequestView.as_view()),
    path('api/token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('api/token/verify/', TokenVerifyView.as_view(), name='token_verify'),
]