import string
from django.shortcuts import render,redirect,HttpResponse,Http404
from django.contrib import messages
from .models import *
from admins.models import *
from user.models import *
from django.conf import settings
import PyPDF2,hmac
from hashlib import *
import random
import os


# Create your views here.
def audits(request):
    return render(request,'audit/audit.html')

def login(request,login):
    if request.method =='POST':
        if login == 'login':
            email=request.POST['email']
            password=request.POST['password']
            try:
                detail=audit.objects.get(email=email,password=password)
                request.session['audit']=detail.name
                messages.success(request,"SUCCESSFULLY LOGGED IN AS AUDITER")
                return redirect('/audit')
            except:
                messages.success(request, "INVALID EMAIL ID OR PASSWORD")
                return redirect('/audit/login/login')
        else:
            name = request.POST['name']
            email = request.POST['email']
            password = request.POST['password']
            auditerid = request.POST['id']
            auditaccess(name=name,email=email,password=password,auditerid=auditerid).save()
            messages.success(request, "DETAILS HAS BEEN REGISTERED SUCCESSFULLY ")
            return redirect('/')
    return render(request,'audit/login.html',{'login':login})

def client(request):
    data=user.objects.filter(area='AUDIT')
    req=requirements.objects.values('type').distinct()
    return render(request,'audit/clients.html',{'data':data,'req':req})

def list(request,userid,type):
    if type == 'none':
        return redirect('/audit/client')
    req=requirements.objects.filter(type=type)
    return render(request,'audit/checklist.html',{'type':type,'userid':userid,'req':req})

def checklist(request,userid):
    if request.method == 'POST':
        type = request.POST.getlist('check')
        requestid=''.join(random.sample(string.digits,k=5))
        for i in type:
            requiredlist(requestid=requestid,userid=userid,list=i).save()
        messages.success(request, "DOCUMENT REQUEST HAS BEEN SENT")
        return redirect('/audit/client')

def request(request):
    data = user.objects.filter(area='AUDIT')
    return render(request,'audit/requestedlist.html',{'data':data})

def viewrequest(request,userid):
    users = user.objects.get(userid=userid)
    lists = requiredlist.objects.filter(userid=userid).values('requestid').distinct()
    return render(request, 'audit/requestedlist1.html', {'list':lists,'u':users})

def viewlist(request,requestid):
    data = requiredlist.objects.filter(requestid=requestid)
    return render(request,'audit/viewlist.html',{'data':data,'requestid':requestid})

def reqaccess(request,requestid,id):
    requiredlist.objects.filter(id=id).update(access=0)
    messages.success(request, "REQUEST FOR THE KEY HAS BEEN SENT TO ADMIN")
    return redirect(f'/audit/view/{requestid}')

def typeupload(request):
    req=requirements.objects.all().order_by('type')
    if request.method=='POST':
        name=request.POST['type']
        docname=request.POST['docname']
        requirements(type=name,documentname=docname).save()
        messages.success(request, "DOCUMENT TYPE AND DOCUMENT NAME HAS BEEN UPDATED")
        return redirect('/audit/typeupload/')
    return render(request,'audit/typeupload.html',{'list':req})

def download(request,file):
    if request.method == 'POST':
        files=open(f'{settings.MEDIA_ROOT}/{file}', 'rb')
        key = request.POST['key']
        pdfReader = PyPDF2.PdfFileReader(files)
        r = pdfReader.numPages
        data = ''
        for p in range(r):
            data += pdfReader.getPage(p).extractText()
        length = len(data) // 4
        f1 = 0
        f2 = length
        initial = ''
        valid =0
        for j in range(4):
            data1 = data[f1:f2]
            f3 = length
            if j == 0:
                d = hmac.new(key.encode(), data1.encode(), sha512).hexdigest()
                times=node1.objects.all()
                for i in times:
                    if d==i.hashvalue:
                        valid+=1
                initial = d
            elif j == 1:
                d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                times = node2.objects.all()
                for i in times:
                    if d == i.hashvalue:
                        valid += 1
                initial = d
            elif j == 2:
                d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                times = node3.objects.all()
                for i in times:
                    if d == i.hashvalue:
                        valid += 1
                initial = d
            elif j == 3:
                d = hmac.new(initial.encode(), data1.encode(), sha512).hexdigest()
                times = node4.objects.all()
                for i in times:
                    if d == i.hashvalue:
                        valid += 1
                initial = d
            f1 += f3
            f2 += f3
        print(valid)
        if valid == 4:
            return redirect(f'/audit/alpha/{file}')
        else:
            return HttpResponse("YOU HAVE ENTERED INVALID KEY")
    return redirect('/audit/request')

def down(request,path):
    file_path = os.path.join(settings.MEDIA_ROOT, str(path))
    if os.path.exists(file_path):
        with open(file_path, 'rb') as fh:
            response = HttpResponse(fh.read(), content_type="application/vnd.ms-excel")
            response['Content-Disposition'] = 'inline; filename=' + os.path.basename(file_path)
            return response
    raise Http404

def logout(request):
    del request.session['audit']
    messages.success(request, "LOGGED OUT SUCCESSFULLY")
    return redirect('/')


