# Cockpit CMS Addon Field AutoURL

This addon creates a field type that auto generates an url on the go.

## Install

Clone this project to the addons folder.

```
cd path/to/cockpit/addons

git clone https://github.com/MarcoDaniels/cockpit-field-autourl.git
```

Create a field `Autourl` field type with a `pattern` string options.

Use a colon `:` to define what field name to use in the pattern:

```
{
  "pattern": "/myprefix/:field1/:field2/"
}
```

**Note:** Currently it only supports field types `text` and `select`