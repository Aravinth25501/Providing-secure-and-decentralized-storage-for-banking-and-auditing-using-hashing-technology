from django.db import models
from django.utils import timezone
# Create your models here.

class bank(models.Model):
    name = models.CharField(max_length=50, null=True, unique=True)
    managerid = models.IntegerField()
    email = models.EmailField(null=True, unique=True)
    password = models.CharField(max_length=50, null=True)

class scheme(models.Model):
    name= models.CharField(max_length=50, null=True)
    definition =models.TextField()
    documentneeded = models.CharField(max_length=50, null=True)

class loan(models.Model):
    type = models.CharField(max_length=50, null=True)
    definition = models.TextField(null=True)
    needfilename = models.CharField(max_length=50, null=True)

class schemeupload(models.Model):
    schemename= models.CharField(max_length=50, null=True)
    name = models.CharField(max_length=50, null=True)
    email = models.EmailField()
    dob = models.DateField()
    contact = models.CharField(max_length=50, null=True)
    patta = models.FileField()
    chitta = models.FileField()
    pattakey = models.CharField(max_length=50, null=True)
    chittakey = models.CharField(max_length=50, null=True)
    userid = models.CharField(max_length=50, null=True)
    uploadid = models.CharField(max_length=50, null=True)
    access=models.BooleanField(null=True)

class loanupload(models.Model):
    loantype = models.CharField(max_length=50, null=True)
    name = models.CharField(max_length=50, null=True)
    email = models.EmailField()
    dob = models.DateField()
    contact = models.CharField(max_length=50, null=True)
    document = models.FileField()
    key = models.CharField(max_length=50, null=True)
    userid = models.CharField(max_length=50, null=True)
    uploadid = models.CharField(max_length=50, null=True)
    access = models.BooleanField(null=True)


