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

  $('.toggler').click(function()
                    {
    if ( ++count % 2 === 1 )
    {
      // Show
      $overlay
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
    }
    else
    {
      // Hide
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
    }

    return false;
  });

  setTimeout(function(){
    $('.toggler').trigger('click');
  }, 500);
});
