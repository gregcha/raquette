$(document).ready(function(){
  var count = 0;
  var $overlay = $('.overlay');
  var $links = $overlay.find('ul')

  $links.velocity({
    opacity: 0.4,
    translateY: '-75%',
    translateX: '-50%',
    rotateX: '35deg'
  }, 0);

  $('.open-toggler').click(function(){
    $('#fullscreen-libelleReservation').html($(this).next('.is-hidden').children('form').children('#libelleReservation').val());
    var $color = $(this).attr('class').split(' ')[0];
    $overlay
      .addClass($color)
      .velocity('stop')
      .velocity('fadeIn', 300);
    $links
      .velocity('stop')
      .velocity({
        opacity: 1,
        translateY: '-50%',
        translateX: '-50%',
        rotateX: '0deg'
      }, 500);
  });

  $('.close-toggler').click(function(){
    $links
      .velocity('stop')
      .velocity({
        opacity: 0.4,
        translateY: '-25%',
        rotateX: '-35deg'
      },
      {
        duration: 250,
        complete: function(elements)
        {
          $links.velocity({
            translateY: '-75%',
            rotateX: '35deg'
          }, 0);
        }
      });


    $overlay
      .velocity('stop')
      .velocity('fadeOut', {
        duration: 200
      });

    var $color = $overlay.attr('class').split(' ')[1];
    $overlay.removeClass($color);
    $('#fullscreen-libelleReservation').html('');
  });

  $('.book-the-court').click(function(){
    var $selected_account = $(this).attr('selected_account');
    var $marker = $('#fullscreen-libelleReservation').html();
    $( "input[value='" + $marker + "']" ).next().val($selected_account);
    $( "input[value='" + $marker + "']" ).next().next().trigger('click');
  });

});










