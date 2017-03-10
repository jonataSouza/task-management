/**
* @file config.js
* @brief CONFIG
* @author JONATA CARDOSO DE SOUZA
* @date 10/03/2017
* @version 1.0
*/
(function() {
  angular
  .module('task')
  .config(config);

  function config($stateProvider) {
    $stateProvider
    .state('app.task', {
      url: "/task",
      templateUrl: "app/task/list.html",
      data: { pageTitle: 'Listagem de task' },
      resolve: {
        loadPlugin: function ($ocLazyLoad) {
          return $ocLazyLoad.load([
          {
            serie: true,
            files: ['js/plugins/dataTables/datatables.min.js','css/plugins/dataTables/datatables.min.css']
          },
          {
            serie: true,
            name: 'datatables',
            files: ['js/plugins/dataTables/angular-datatables.min.js']
          },
          {
            serie: true,
            name: 'datatables.buttons',
            files: ['js/plugins/dataTables/angular-datatables.buttons.min.js']
          }
          ]);
        }
      }
    })
    .state('app.task-add', {
      url: "/task/adicionar",
      templateUrl: "app/task/persist.html",
      data: { pageTitle: 'Adicionar task' }
    })
    .state('app.task-edit', {
      url: "/task/editar/:codTask",
      templateUrl: "app/task/persist.html",
      data: { pageTitle: 'Editar task' }
    });
  }
})();
