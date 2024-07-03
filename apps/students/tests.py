from django.test import TestCase
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient
from .models import Student


class StudentAPITestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.student_data = {'name': 'John Doe', 'email': 'john@example.com', 'age': 20, 'grade': 'A'}
        self.student = Student.objects.create(**self.student_data)

    def test_create_student(self):
        response = self.client.post(reverse('student-list'), self.student_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_get_students(self):
        response = self.client.get(reverse('student-list'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_get_student(self):
        response = self.client.get(reverse('student-detail', kwargs={'pk': self.student.id}))
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_update_student(self):
        updated_data = {'name': 'Jane Doe', 'email': 'jane@example.com', 'age': 21, 'grade': 'B'}
        response = self.client.put(reverse('student-detail', kwargs={'pk': self.student.id}), updated_data,
                                   format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    def test_delete_student(self):
        response = self.client.delete(reverse('student-detail', kwargs={'pk': self.student.id}))
        self.assertEqual(response.status_code, status.HTTP_204_NO_CONTENT)

    def test_healthcheck(self):
        response = self.client.get(reverse('healthcheck'))
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, {"status": "healthy"})
