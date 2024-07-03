from django.urls import path
from . import views

urlpatterns = [
    path('students/', views.StudentList.as_view(), name='student-list'),
    path('students/<int:pk>/', views.StudentDetail.as_view(), name='student-detail'),
    path('healthcheck/', views.HealthCheck.as_view(), name='healthcheck'),
]
