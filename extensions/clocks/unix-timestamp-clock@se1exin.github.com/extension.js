const St = imports.gi.St;
const Main = imports.ui.main;
const GnomeDesktop = imports.gi.GnomeDesktop;
const Lang = imports.lang;
const Shell = imports.gi.Shell;

let text, button, label;
let clock, clock_signal_id;

function init() {
    clock = new GnomeDesktop.WallClock();
    button = new St.Bin({
        style_class: 'panel-button',
        reactive: true,
        can_focus: false,
        x_expand: true,
        y_expand: false,
        track_hover: true
    });
    label = new St.Label({
        style_class: 'unixtime',
        text: '',
        y_align: St.Align.END,
        opacity: 200
    });

    button.set_child(label);
    
    button.connect('button-press-event', function(actor, e){
        if(e.get_button() !== 1) {
            var now = new Date();
            St.Clipboard.get_default().set_text(St.ClipboardType.CLIPBOARD, Math.round(now.getTime() / 1000).toString());
        } else {
            St.Clipboard.get_default().set_text(St.ClipboardType.CLIPBOARD, label.get_text());
        }
    });
}

function enable() {
    update_time();
    clock_signal_id = clock.connect('notify::clock', Lang.bind(this, this.update_time));
    Main.panel._centerBox.insert_child_at_index(button, 1);
}

function disable() {
    Main.panel._centerBox.remove_child(button);
    clock.disconnect(clock_signal_id);
}

function update_time() {
    var now = new Date();
    label.set_text(Math.round(now.getTime() / 1000).toString());
}
