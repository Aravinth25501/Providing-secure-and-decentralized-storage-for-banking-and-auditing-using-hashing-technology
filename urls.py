from django.urls import path
from . import views

urlpatterns = [
    path('',views.audits),
    path('login/<str:login>/', views.login),
    path('client/', views.client),
    path('list/<str:userid>/<str:type>', views.list),
    path('request/', views.request),
    path('viewrequest/<str:userid>', views.viewrequest),
    path('view/<str:requestid>', views.viewlist),
    path('checklist/<str:userid>', views.checklist),
    path('reqaccess/<str:requestid>/<str:id>', views.reqaccess),
    path('typeupload/', views.typeupload),
    path('download/<str:file>', views.download),
    path('alpha/<str:path>', views.down),
    path('logout/', views.logout),

]
