/**
* @file persist.controller.js
* @brief PERSISTÊNCIA CONTROLLER
* @author JONATA CARDOSO DE SOUZA
* @date 10/03/2017
* @version 1.0
*/

(function (){
	angular
	.module('task')
	.controller('TaskPersistController', TaskPersistController);

	function TaskPersistController($http, $state) {
		var vm = this;
		params = $state.params;
		codTask = params.codTask;
		vm.data = {cod_status: '1'};
		vm.fnPersist = fnPersist;

    if (typeof(codTask) != 'undefined') {
     fnExibirDados(codTask);
   }

   function fnPersist() {
     $http.post('app/task/persist.php', vm.data)
     .then(
      function(response) {
       swal(response.data.str_retorno, "", "success");
       $state.go('app.task');
     },
     function(response) {
       swal(response.data.str_retorno, "", "error");
     }
     );
   }

   function fnExibirDados(codTask) {
     $http.get('app/task/list.php', {params: {codTask: codTask}})
     .then(function(response) {
      vm.data = response.data[0];
    });
   }
 }
})();
