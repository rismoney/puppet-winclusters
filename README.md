puppet-winclusters
==================

puppet windows cluster module

Initial notes:
* facter facts needed:
   (1) determine cluster service state 
   (2) determine if virtual cluster name exists

* idempotency approach
  
  * only deploy cluster module to intended hosts
  * if intended host has no cluster svc
       install dism features
  * if intended host has cluster cluster svc disabled
       run install cluster if no existing cluster exists
       run join existing cluster if existing cluster exists
  * if cluster all ready configured
       install cluster resources 

work in progress...

      