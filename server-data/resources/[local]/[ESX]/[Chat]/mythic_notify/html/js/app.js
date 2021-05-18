var persistentNotifs = {};

window.addEventListener('message', function (event) {
    ShowNotif(event.data);
});

function CreateNotification(data) {
    var $notification = $(document.createElement('div'));
    $notification.addClass('notification').addClass(data.type);
    if (data.type == "success") {
        $notification.html('<i class="fas fa-check-circle" ></i> '+data.text);
    } else if (data.type == "inform") {
        $notification.html('<i class="fas fa-info-circle" ></i> '+data.text);
    } else if (data.type == "error") {
        $notification.html('<i class="fas fa-exclamation-triangle"></i> '+data.text);
    } else {
        $notification.html(data.text);
    }
    // $notification.fadeIn();
    $notification.fadeIn()
    .css({right:-140+"%",position:'relative'})
    .animate({right:5+"%"}, 400, function() {
        //callback
    });
    if (data.style !== undefined) {
        Object.keys(data.style).forEach(function(css) {
            $notification.css(css, data.style[css])
        });
    }

    return $notification;
}

function ShowNotif(data) {
    if (data.persist === undefined) {
        var $notification = CreateNotification(data);
        $('.notif-container').append($notification);
        let fadetimer = data.length != null ? data.length :3000
        setTimeout(function() {
            $.when($notification.fadeOut(fadetimer-(fadetimer / 2))).done(function() {
                $notification.remove()
            });
        }, fadetimer / 2);
    } else {
        if (data.persist.toUpperCase() == 'START') {
            if (persistentNotifs[data.id] === undefined) {
                var $notification = CreateNotification(data);
                $('.notif-container').append($notification);
                persistentNotifs[data.id] = $notification;
            } else {
                let $notification = $(persistentNotifs[data.id])
                $notification.addClass('notification').addClass(data.type);
                $notification.html(data.text);

                if (data.style !== undefined) {
                    Object.keys(data.style).forEach(function(css) {
                        $notification.css(css, data.style[css])
                    });
                }
            }
        } else if (data.persist.toUpperCase() == 'END') {
            let $notification = $(persistentNotifs[data.id]);
            $.when($notification.fadeOut()).done(function() {
                $notification.remove();
                delete persistentNotifs[data.id];
            });
        }
    }
}