$(document).ready(function() {


  //--------
  // WHERE
  //--------

  // SELECT TENNIS

  $('#tennisArrond').select2({
    minimumResultsForSearch: -1,
  });
  $("#tennisArrond").select2("val", "[]");

  $('#form-where-tennis').click(function() {
    $('#tennisArrond').select2('open');
    $('#form-where-tennis a').html('Choisir un tennis <i class="fa fa-caret-up" aria-hidden="true"></i>');
    $('#form-where-ardts a').html('3 arrondissements max <i class="fa fa-caret-down" aria-hidden="true"></i>');
    $('#form-where-ardts a').show();
    $("#tousArrondissements").prop('checked', false);
    $("#arrondissement").select2("val", "[]");
  });

  $('#tennisArrond').on("select2:select", function(e) {
    var data = $('#tennisArrond').select2('data');
    $('#form-where-tennis a').html(data[0]['text']);
    $("#form-where-tennis a").addClass('form-where-option-selected');
  });


  // SELECT ARDTS

  $('#arrondissement').select2({
    maximumSelectionLength: 3,
    closeOnSelect: false,
  });

  $('#form-where-ardts').click(function() {
    $('#arrondissement').select2('open');
    $('#form-where-ardts a').html('3 arrondissements max <i class="fa fa-caret-up" aria-hidden="true"></i>');
    $("#tousArrondissements").prop('checked', false);
    $("#tennisArrond").select2("val", "[]");
    $("#form-where-tennis a").removeClass('form-where-option-selected');
    $('#form-where-tennis a').html('Choisir un tennis <i class="fa fa-caret-down" aria-hidden="true"></i>');
  });

  $('#arrondissement').on("select2:select", function(e) {
    $('#form-where-ardts a').hide();
    if ($("#arrondissement").select2("val").length > 2) {
      $('#arrondissement').select2('close');
    };
  });

  //--------
  // WHEN
  //--------

  // DATE
  $('.form-date-option').click(function() {
    if ($(this).hasClass('form-date-option-selected')) {
      $(this).removeClass('form-date-option-selected');
      $('#dateDispo').val('');
    }
    else {
      $('.form-date-option').removeClass('form-date-option-selected');
      $(this).addClass('form-date-option-selected');
      var date = $(this).attr("id");
      $('#dateDispo').val(date);
    }
  });

  // HOUR
  $('.form-hour-option').click(function() {
    if ($(this).hasClass('form-hour-option-selected')) {
      $(this).removeClass('form-hour-option-selected');
      $('#plageHoraireDispo').val('');
    }
    else {
      $('.form-hour-option').removeClass('form-hour-option-selected');
      $(this).addClass('form-hour-option-selected');
      var hour = $(this).attr("id");
      $('#plageHoraireDispo').val(hour);

    }
  });

  //--------
  // MORE
  //--------

  // COUVERT
  $('#tgl_bgd_couvert input').on('change', function() {
    if ($(this).is(':checked')) {
      $("#courtCouvert").prop('checked', true);
    }
    else {
      $("#courtCouvert").prop('checked', false);
    }
  });

  // ECLAIRE
  $('#tgl_bgd_eclaire input').on('change', function() {
    if ($(this).is(':checked')) {
      $("#courtEclaire").prop('checked', true);
    }
    else {
      $("#courtEclaire").prop('checked', false);
    }
  });

  // SURFACE
  $('#revetement').select2({
    minimumResultsForSearch: -1,
    placeholder:'Choisir surface',
  });

});


