from django.urls import path
from . import views

urlpatterns = [
    path('', views.banks),
    path('login/<str:login>/', views.login),
    path('status/', views.status),
    path('activate/<str:userid>', views.activate),
    path('account/', views.account),
    path('document1/<int:userid>', views.registerdocument),
    path('download1/<str:file>', views.download1),
    path('alpha/<str:file>', views.downloads),
    path('postscheme/', views.postscheme),
    path('postloan/', views.postloan),
    path('scheme/', views.schemelist),
    path('document2/<str:schemename>', views.appliedschemes),
    path('document3/<str:loan>', views.appliedloan),
    path('documentview2/<str:uploadid>', views.documentview2),
    path('documentview3/<str:uploadid>', views.documentview3),
    path('request/<str:uploadid>/<str:type>', views.keyaccess),
    path('loan/', views.loans),
    path('logout/', views.logout),

]