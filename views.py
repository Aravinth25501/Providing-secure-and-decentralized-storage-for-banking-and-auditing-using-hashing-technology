from django.shortcuts import render,redirect,HttpResponse,Http404
from .models import *
from django.contrib import messages
from admins.models import *
from user.models import *
from django.conf import settings
import PyPDF2,hmac
from hashlib import *
import os


# Create your views here.
def banks(request):
    return render(request,'bank/bank.html')

def login(request,login):
    if request.method =='POST':
        if login == 'login':
            email=request.POST['email']
            password=request.POST['password']
            try:
                detail=bank.objects.get(email=email,password=password)
                request.session['bank']=detail.name
                messages.success(request, "SUCCESSFULLY LOGGED IN AS BANK MANAGER")
                return redirect('/bank')
            except:
                messages.success(request, "INVALID EMAIL ID OR PASSWORD")
                return redirect('/bank/login/login')
        else:
            name= request.POST['name']
            email = request.POST['email']
            password = request.POST['password']
            managerid = request.POST['id']
            bankaccess(name=name,email=email,password=password,managerid=managerid).save()
            messages.success(request, "SUCCESSFULLY REGISTERED AS BANK MANAGER")
            return redirect('/')
    return render(request,'bank/login.html',{'login':login})

def status(request):
    data=user.objects.filter(area='BANK')
    return render(request,'bank/status.html',{'data':data})

def account(request):
    register=bankaccount.objects.all()
    return render(request,'bank/account.html',{'register':register})

def activate(request,userid):
    user.objects.filter(userid=userid).update(status=True)
    return redirect('/bank/account/')

def registerdocument(request,userid):
    data = bankaccount.objects.get(userid=userid)
    return render(request,'bank/document1.html',{'data':data})

def appliedschemes(request,schemename):
    data = schemeupload.objects.filter(schemename=schemename)
    return render(request,'bank/appliedscheme.html',{'data':data})

def documentview2(request,uploadid):
    data = schemeupload.objects.get(uploadid=uploadid)
    return render(request,'bank/document1.html',{'data2':data})

def appliedloan(request,loan):
    loandata = loanupload.objects.filter(loantype=loan)
    return render(request,'bank/appliedloan.html',{'loandata':loandata})

def documentview3(request,uploadid):
    data = loanupload.objects.get(uploadid=uploadid)
    return render(request,'bank/document1.html',{'data3':data})

def download1(request,file):
    if request.method== 'POST':
        files = open(f'{settings.MEDIA_ROOT}/{file}', 'rb')
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
        valid = 0
        for j in range(4):
            data1 = data[f1:f2]
            f3 = length
            if j == 0:
                d = hmac.new(key.encode(), data1.encode(), sha512).hexdigest()
                times = node1.objects.all()
                for i in times:
                    if d == i.hashvalue:
                        valid += 1
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
        if valid == 4:
            return redirect(f'/audit/alpha/{file}')
        else:
            return HttpResponse("YOU HAVE ENTERED INVALID KEY")
    return redirect('/bank/account/')

def downloads(request,path):
    file_path = os.path.join(settings.MEDIA_ROOT, str(path))
    if os.path.exists(file_path):
        with open(file_path, 'rb') as fh:
            response = HttpResponse(fh.read(), content_type="application/vnd.ms-excel")
            response['Content-Disposition'] = 'inline; filename=' + os.path.basename(file_path)
            return response
    raise Http404

def postscheme(request):
    if request.method =='POST':
        name=request.POST['name']
        docname = request.POST['docname']
        schemes = request.POST['message']
        scheme(name=name,definition=schemes,documentneeded=docname).save()
        messages.success(request, "SCHEME HAS BEEN UPLOADED")
    return render(request,'bank/scheme.html')

def postloan(request):
    if request.method =='POST':
        name=request.POST['loan']
        need = request.POST['need']
        description = request.POST['description']
        loan(type=name,definition=description,needfilename=need).save()
        messages.success(request, "LOAN HAS BEEN UPLOADED")
    return render(request,'bank/loanupload.html')

def schemelist(request):
    schemes=scheme.objects.all()
    return render(request,'bank/schemelist.html',{'scheme':schemes})

def loans(request):
    loans=loan.objects.all()
    return render(request,'bank/loan.html',{'loan':loans})

def keyaccess(request,uploadid,type):
    if type=="scheme":
        schemeupload.objects.filter(uploadid=uploadid).update(access=0)
        messages.success(request, "KEY FOR DOCUMENT UNDER SCHEME HAS BEEN REQUESTED")
        return redirect(f'/bank/documentview2/{uploadid}')
    elif type=="loan":
        messages.success(request, "KEY FOR DOCUMENT UNDER LOAN HAS BEEN REQUESTED")
        loanupload.objects.filter(uploadid=uploadid).update(access=0)
        return redirect(f'/bank/documentview3/{uploadid}')
    else:
        messages.success(request, "KEY FOR DOCUMENT FOR THE CREATION OF ACCOUNT HAS BEEN REQUESTED")
        bankaccount.objects.filter(uploadid=uploadid).update(access=0)
        return redirect(f'/bank/account/')

def logout(request):
    del request.session['bank']
    messages.success(request, "LOGGED OUT SUCCESSFULLY")
    return redirect('/')