from django.db import models

# Create your models here.
class user(models.Model):
    name = models.CharField(max_length=50, null=True)
    area = models.CharField(max_length=50, null=True)
    email = models.EmailField(null=True)
    userid = models.CharField(max_length=50, null=True)
    password = models.CharField(max_length=50, null=True)
    status = models.BooleanField(default=0)

class bankaccount(models.Model):
    userid = models.CharField(max_length=50, null=True)
    name = models.CharField(max_length=50, null=True)
    fathername= models.CharField(max_length=50, null=True)
    email = models.EmailField()
    contact = models.BigIntegerField(null=True)
    address = models.TextField()
    aadhaar=models.FileField()
    pancard=models.FileField()
    photo=models.FileField()
    aadhaarkey=models.CharField(max_length=50, null=True)
    pancardkey=models.CharField(max_length=50, null=True)
    photokey=models.CharField(max_length=50, null=True)
    uploadid = models.CharField(max_length=50, null=True)
    access = models.BooleanField(null=True)

class node1(models.Model):
    key= models.CharField(max_length=50, null=True)
    hashvalue=models.TextField()
    filename=models.CharField(max_length=50, null=True)

class node2(models.Model):
    key= models.CharField(max_length=50, null=True)
    hashvalue=models.TextField()
    filename=models.CharField(max_length=50, null=True)

class node3(models.Model):
    key= models.CharField(max_length=50, null=True)
    hashvalue=models.TextField()
    filename=models.CharField(max_length=50, null=True)

class node4(models.Model):
    key= models.CharField(max_length=50, null=True)
    hashvalue=models.TextField()
    filename=models.CharField(max_length=50, null=True)

