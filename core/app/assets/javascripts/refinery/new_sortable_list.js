//  Reorder/reorder done buttons
    // <a id="reorder_pages" title="Reorder pages" class="reorder reorder_icon" href="/refinery/pages" data-target="#records">Reorder pages</a>
    // <a id="reorder_pages_done" class="hide reorder_done_icon reorder_done" title="Done reordering pages" data-target="#records" href="/refinery/pages">Done reordering pages</a>

var options = {
   onDrop: function  (item, targetContainer, _super) {
     var clonedItem = $('<li/>').css({height: 0});
     item.before(clonedItem);
     clonedItem.animate({'height': item.height()});

     item.animate(clonedItem.position(), function  () {
       clonedItem.detach();
       _super(item);
     });
   }
};

$('.sortable_list').each(function(){
    this.sortable(options).sortable('disable');
  });

$('.reorder').on('click', start_reorder);
$('.reorder_done').on('click', finish_reorder);

start_reorder = function (e) {
  e.preventDefault();
  console.log("Reordering started");
  $(this).data('target').sortable('enable');
  $('.reorder', '.reorder_done').toggle();
};

finish_reorder = function(e) {
  e.preventDefault();
  console.log('Reordering finished');
  $(this).data('target').sortable('disable');
  $('.reorder', '.reorder_done').toggle();
//   now gather the new order and send it back to the db
  var data = $(this).sortable("serialize").get();
  console.log(data);
  // $.ajax({
    // url: update_url,

  // })
};
