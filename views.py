from django.shortcuts import render,redirect
from .models import *
from audit.models import *
from bank.models import *
from user.models import *
# Create your views here.
def admins(request):
    return render(request,'admin/admin.html')

def login(request):
    if request.method == 'POST':
        email=request.POST['email']
        password = request.POST['password']
        try:
            detail=admin.objects.get(email=email,password=password)
            request.session['admin']=detail.name
            return redirect('/admin1')
        except:
            return redirect('/admin1/login')
    return render(request,'admin/login.html')
def audittable(request):
    data=auditaccess.objects.all()
    return render(request,'admin/auditaccess.html',{'data':data})

def banktable(request):
    data = bankaccess.objects.all()
    return render(request,'admin/bankaccess.html',{'data':data})

def usertable(request):
    data = useraccess.objects.all()
    return render(request,'admin/useraccess.html',{'data':data})

def auditapprove(request,name,email,auditerid,password):
    audit(name=name, email=email, auditerid=auditerid, password=password).save()
    auditaccess.objects.filter(name=name,email=email,auditerid=auditerid,password=password).delete()
    return redirect('/admin1/auditaccess')

def bankapprove(request,name,email,managerid,password):
    bank(name=name,email=email,managerid=managerid,password=password).save()
    bankaccess.objects.filter(name=name,email=email,managerid=managerid,password=password).delete()
    return redirect('/admin1/bankaccess')

def userapprove(request,name,email,type,password,userid):
    user(name=name,email=email,area=type,password=password,userid=userid).save()
    useraccess.objects.filter(name=name,email=email,area=type,password=password).delete()
    return redirect('/admin1/useraccess')

def audits(request):
    data = audit.objects.all()
    return render(request,'admin/audit.html',{'data':data})

def banks(request):
    data = bank.objects.all()
    return render(request,'admin/bank.html',{'data':data})

def users(request):
    data = user.objects.all()
    return render(request,'admin/user.html',{'data':data})

def keyaccess(request):
    data=requiredlist.objects.filter(access=0)
    if request.method=='POST':
        key=request.POST['key'][2:]
        requiredlist.objects.filter(key=key).update(access=1)
        return redirect('/admin1/keyaccess')
    return render(request,'admin/keyaccess.html',{'data':data})

def bankkey(request):
    data=schemeupload.objects.filter(access=0)
    data1=loanupload.objects.filter(access=0)
    data2 = bankaccount.objects.filter(access=0)
    if request.method=='POST':
        if request.POST['type']=='scheme':
            key=request.POST['key'][2:]
            schemeupload.objects.filter(pattakey=key).update(access=1)
        elif request.POST['type']=='bank':
            id = request.POST['id']
            bankaccount.objects.filter(id=id).update(access=1)
        else:
            key = request.POST['key'][2:]
            loanupload.objects.filter(key=key).update(access=1)
        return redirect('/admin1/bankkey')
    return render(request,'admin/bankkey.html',{'data':data,'data1':data1,'data2':data2})

def logout(request):
    del request.session['admin']
    return redirect('/')
