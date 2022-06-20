from django.db import models

# Create your models here.
class audit(models.Model):
    name = models.CharField(max_length=50, null=True, unique=True)
    email = models.EmailField(null=True, unique=True)
    auditerid = models.IntegerField()
    password = models.CharField(max_length=50, null=True)

class requiredlist(models.Model):
    userid = models.CharField(max_length=50, null=True)
    requestid = models.CharField(max_length=50, null=True)
    list = models.TextField()
    file= models.FileField(null=True)
    key = models.CharField(max_length=50, null=True)
    access = models.BooleanField(null=True)

class requirements(models.Model):
    type=models.CharField(max_length=50, null=True)
    documentname=models.CharField(max_length=50, null=True)
