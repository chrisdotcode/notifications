/*
* Copyright 2019 elementary, Inc. (https://elementary.io)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
*/

public class Notifications.MainWindow : Gtk.Window {
    public string description { get; construct set; }

    public MainWindow () {
        Object (
            icon_name: "io.elementary.notifications",
            type_hint: Gdk.WindowTypeHint.NOTIFICATION,
            title: "Notification Title",
            description: "Notification body that contains a description that could be long and need wrapping or truncating"
        );
    }

    construct {
        var headerbar = new Gtk.HeaderBar ();
        headerbar.custom_title = new Gtk.Grid ();

        var headerbar_style_context = headerbar.get_style_context ();
        headerbar_style_context.add_class ("default-decoration");
        headerbar_style_context.add_class (Gtk.STYLE_CLASS_FLAT);

        set_titlebar (headerbar);

        var image = new Gtk.Image.from_icon_name ("application-default-icon", Gtk.IconSize.DIALOG);
        image.valign = Gtk.Align.START;
        image.pixel_size = 48;

        var markup_attribute = new Pango.AttrList ();
        markup_attribute.insert (Pango.attr_weight_new (Pango.Weight.BOLD));

        var title_label = new Gtk.Label (null);
        title_label.attributes = markup_attribute;
        title_label.ellipsize = Pango.EllipsizeMode.END;
        title_label.valign = Gtk.Align.END;
        title_label.xalign = 0;

        var description_label = new Gtk.Label (null);
        description_label.ellipsize = Pango.EllipsizeMode.END;
        description_label.lines = 2;
        description_label.valign = Gtk.Align.START;
        description_label.wrap = true;
        description_label.xalign = 0;

        bind_property ("title", title_label, "label");
        bind_property ("description", description_label, "label");

        var grid = new Gtk.Grid ();
        grid.column_spacing = 6;
        grid.margin = 6;
        grid.margin_top = 0;
        grid.attach (image, 0, 0, 1, 2);
        grid.attach (title_label, 1, 0);
        grid.attach (description_label, 1, 1);

        var style_context = get_style_context ();
        style_context.add_class ("rounded");
        style_context.add_class ("notification");

        default_width = 300;
        add (grid);

        GLib.Timeout.add (2500, () => {
            destroy ();
            return false;
        });
    }
}

