$(document).ready(function() {


  //--------
  // WHERE
  //--------

  // SELECT ALL
  $("#form-where-visible-all").on("click", function () {
    $("#tousArrondissements").prop('checked', true);
    $("#form-where-visible-all").addClass('form-where-visible-option-selected')
    $("#form-where-visible-tennis").removeClass('form-where-visible-option-selected');
    $("#tennisArrond").select2("val", "[]");
    $('#form-where-visible-tennis').html('Choisir tennis');
    $('#arrondissement').parent().removeClass('form-where-hidden-option-visible');
    $("#arrondissement").select2("val", "[]");
  });

  // SELECT TENNIS

  $('#tennisArrond').select2();
  $("#tennisArrond").select2("val", "[]");

  $('#form-where-visible-tennis').click(function() {
    $('#tennisArrond').select2('open');
    $("#tousArrondissements").prop('checked', false);
    $("#form-where-visible-all").removeClass('form-where-visible-option-selected');
    $('#arrondissement').parent().removeClass('form-where-hidden-option-visible');
    $("#arrondissement").select2("val", "[]");
  });

  $('#tennisArrond').on("select2:select", function(e) {
    var data = $('#tennisArrond').select2('data');
    $('#form-where-visible-tennis').html(data[0]['text']);
    $("#form-where-visible-tennis").addClass('form-where-visible-option-selected');
  });


  // SELECT ARDTS

  $('#arrondissement').select2({
    maximumSelectionLength: 3,
    closeOnSelect: false,
  });

  $('#form-where-visible-ardt').click(function() {
    $('#arrondissement').select2('open');
    $('#arrondissement').parent().addClass('form-where-hidden-option-visible');
    $("#tousArrondissements").prop('checked', false);
    $("#form-where-visible-all").removeClass('form-where-visible-option-selected');
    $("#form-where-visible-tennis").removeClass('form-where-visible-option-selected');
    $("#tennisArrond").select2("val", "[]");
    $('#form-where-visible-tennis').html('Choisir tennis');
  });

  $('#arrondissement').on("select2:select", function(e) {
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
    placeholder:'Choisir surface',
  });

});


