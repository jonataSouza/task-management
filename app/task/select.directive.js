/**
* @file select.controller.js
* @brief SELECT DIRECTIVE
* @author JONATA CARDOSO DE SOUZA
* @date 10/03/2017
* @version 1.0
*/
(function() {
  angular.module('task')
  .directive('taskSelect', function($http) {
    return {
      restrict: 'E',
      scope: {
        ngModel: '='
      },
      controller: function($scope, $element, $http) {
        fnMontaTask();
        function fnMontaTask() {
          $http.get("app/task/list.php")
          .then(
            function(response) {
              if (response.data.length == 0) {
                $scope.arrTask = [{}];
                $scope.strPlaceholder = 'Nenhum resultado encontrado...';
                return;
              }
              $scope.arrTask = response.data;
              $scope.strPlaceholder = 'Selecione a task...';
            },
            function() {
              swal("Requisição não aceita!", "", "error");
            }
            );
        }
      },
      template:
      '<select chosen class="chosen-select form-control" data-placeholder-text-single="\'Selecione a task...\'" ' +
      'ng-options="objTask.dsc_task for objTask in arrTask track by objTask.cod_task">' +
      '<option value=""></option>' +
      '</select>',
      replace: true
    }
  });
})();
