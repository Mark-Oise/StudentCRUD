import logging
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework import generics
from rest_framework.views import APIView

from .models import Student
from .serializers import StudentSerializer

logger = logging.getLogger(__name__)


class StudentList(generics.ListCreateAPIView):
    queryset = Student.objects.all()
    serializer_class = StudentSerializer

    def list(self, request, *args, **kwargs):
        logger.info('Fetching all students')
        return super().list(request, *args, **kwargs)

    def create(self, request, *args, **kwargs):
        logger.info("Creating a new student")
        return super().create(request, *args, **kwargs)


class StudentDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Student.objects.all()
    serializer_class = StudentSerializer

    def retrieve(self, request, *args, **kwargs):
        logger.info(f"Fetching student with id {kwargs['pk']}")
        return super().retrieve(request, *args, **kwargs)

    def update(self, request, *args, **kwargs):
        logger.info(f"Updating student with id {kwargs['pk']}")
        return super().update(request, *args, **kwargs)

    def destroy(self, request, *args, **kwargs):
        logger.info(f"Deleting student with id {kwargs['pk']}")
        return super().destroy(request, *args, **kwargs)


class HealthCheck(APIView):
    def get(self, request):
        logger.info("Health check requested")
        return Response({"status": "healthy"}, status=status.HTTP_200_OK)
