/**
* @file config.js
* @brief CONFIG ROUTER
* @author JONATA CARDOSO DE SOUZA
* @date 09/03/2017
* @version 1.0
*/
function config($stateProvider, $urlRouterProvider, $ocLazyLoadProvider, IdleProvider, KeepaliveProvider) {
  IdleProvider.idle(5);
  IdleProvider.timeout(120);
  $urlRouterProvider.otherwise("/task");
  $ocLazyLoadProvider.config({
    debug: false
  });

  $stateProvider
  .state('app', {
    abstract: true,
    url: "",
    templateUrl: "app/common/content.html"
  });
}

angular
.module('task')
.config(config)
.run(function($rootScope, $state) {
  $rootScope.$state = $state;
});
