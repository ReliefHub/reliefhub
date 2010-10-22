$(document).ready(function (){  

  /* Standard API Call */
  $('#thumbFeatures').jshowoff({ 
    cssClass: 'thumbFeatures',
    effect: 'slideLeft',
    controls: true,
    autoPlay: false,
  }); 
  
  /* jShowoff does the thumbnail w/ background images in the .css file, find and replace them 
  with ours in a hidden div on the page, much more control*/
  $('.jshowoff-slidelinks > a').each(function(index) {
    $(this).css('background-image','url('+$('#thumbnail_'+index).attr('src')+')')
  })
});