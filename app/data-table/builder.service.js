/**
* @file build-options.service.js
* @brief BUILD OPTIONS SERVICES
* @author JONATA CARDOSO DE SOUZA
* @date 10/03/2017
* @version 1.0
*/
(function() {
  angular.module('task')
  .service('DataTableBuilder', function(DTOptionsBuilder, DTColumnBuilder) {

    this.buildOptions = function(excelTitle, printTitle) {
      if (excelTitle === undefined) {
        excelTitle = 'Controle de Ativos';
      }
      if (printTitle === undefined) {
        printTitle = 'Controle de Ativos';
      }

      return DTOptionsBuilder.newOptions()
      .withDOM('<"html5buttons"B>lTfgitp')
        // Do not forget to add the scorllY option!!!
        .withOption('scrollX', '100%')
        .withButtons([
          {
            extend: 'excel',
            title: excelTitle,
            exportOptions: {
                columns: '.export-column'
            }
          },
          {
            extend: 'print',
            title: printTitle,
            exportOptions: {
                columns: '.export-column'
            },
            customize: function (win){
             $(win.document.body).addClass('white-bg');
             $(win.document.body).css('font-size', '10px');
             $(win.document.body).find('table')
              .addClass('compact')
              .css('font-size', 'inherit');
           }
         }
       ]);
      };

    });
})();
