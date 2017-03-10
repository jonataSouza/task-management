/**
* @file list.controller.js
* @brief LIST CONTROLLER
* @author JONATA CARDOSO DE SOUZA
* @date 10/03/2017
* @version 1.0
*/
(function (){

	angular
	.module('task')
	.controller('TaskListController', TaskListController);

	function TaskListController($http, DataTableBuilder,$base64) {

		var vm = this;
		vm.arrTask = [];
		vm.fnRemoveTask = fnRemoveTask;
		vm.dtOptions = DataTableBuilder.buildOptions();

    fnListaTask();

    function fnListaTask() {
     $http.get('app/task/list.php')
     .success(function(data) {
      vm.arrTask = data;
    })
     .error(function() {
      swal("Requisição não aceita!", "", "error");
    });
   }

   function fnRemoveTask(codTask) {
     swal({
      title: "Confirmar remoção?",
      text: "",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      cancelButtonText: "Cancelar",
      confirmButtonText: "Sim, remover!",
      closeOnConfirm: false
    },
    function() {
      $http.delete('app/task/remove.php', {params: {codTask: codTask}})
      .then(
       function(response) {
         vm.arrTask = vm.arrTask.filter(function(task) {
           return task.cod_task != codTask;
         });
         swal(response.data.str_retorno, "", "success");
       },
       function(response) {
        swal(response.data.str_retorno, "", "error");
      }
      )
    }
    )
   }
 }
})();
