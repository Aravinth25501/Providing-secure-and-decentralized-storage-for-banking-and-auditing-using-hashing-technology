from django.db import models

# Create your models here.
class admin(models.Model):
    name= models.CharField(max_length=50,null=True,unique=True)
    email = models.EmailField(null=True)
    password = models.CharField(max_length=50,null=True)

class bankaccess(models.Model):
    name = models.CharField(max_length=50, null=True, unique=True)
    managerid = models.IntegerField()
    email = models.EmailField(null=True, unique=True)
    password = models.CharField(max_length=50, null=True)

class auditaccess(models.Model):
    name = models.CharField(max_length=50, null=True, unique=True)
    email = models.EmailField(null=True, unique=True)
    auditerid = models.IntegerField()
    password = models.CharField(max_length=50, null=True)

class useraccess(models.Model):
    name = models.CharField(max_length=50, null=True, unique=True)
    area = models.CharField(max_length=50, null=True)
    email = models.EmailField(null=True, unique=True)
    password = models.CharField(max_length=50, null=True)
    userid = models.CharField(max_length=50, null=True)
