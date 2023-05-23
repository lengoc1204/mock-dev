from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils.translation import gettext_lazy as _
# Create your models here.


class User(AbstractUser):
      username = models.CharField(max_length=50, unique=True)
      email = models.EmailField(_('email address'), unique=True)
      phone_number = models.CharField(max_length=11, blank=True, null=True)
      birth_date = models.DateField(null=True, blank=True)
      avatar = models.ImageField(upload_to='avatars/', null=True, blank=True)


      REQUIRED_FIELDS = ['first_name', 'last_name']

      def __str__(self):
          return "{}".format(self.email)