import 'dart:io';

class Enviroments {

  static String apiUrl = Platform.isAndroid ? 'http://192.168.0.16:8081/api' : 'http://localhost:5000/api';
  static String socketUrl = Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
  static String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoidGVzdEB0ZXN0LmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMGE5YjUwNDItMTI1Ny00ZDU4LWFjYTMtNjU4ODNmYTc3NWExIiwianRpIjoiYWU5YWU5NzItOWQ1Ny00MGRkLWE4MmItYzJjNzM2YmYxYTkxIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiQ3VzdG9tZXIiLCJleHAiOjE2MDUzOTA2NzgsImlzcyI6Imh0dHA6Ly8xOTIuMTY4LjAuMTY6ODA4MSIsImF1ZCI6Imh0dHA6Ly8xOTIuMTY4LjAuMTY6ODA4MSJ9.oInPAVV-hVxZz9dWxAhrQS7_sokIBP4q-MBj-iy4leA";

}