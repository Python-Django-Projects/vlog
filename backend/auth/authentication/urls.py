from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView
from .views import user_register_view,MyTokenObtainPairSerializer,DisplayList,DisplayDetail

urlpatterns = [
    path('login/', MyTokenObtainPairSerializer.as_view(), name='login'),
    path('login/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('register/', user_register_view, name='register'),
    
    # CRUD
    path('users/', DisplayList.as_view(), name='users'), 
    path('users/<int:pk>/', DisplayDetail.as_view(), name='users'),
    
]
