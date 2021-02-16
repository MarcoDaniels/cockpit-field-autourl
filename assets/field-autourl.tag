<field-autourl>
    <div class="uk-position-relative field-text-container">
        <input ref="input"
               oninput="{onInput}"
               class="uk-width-1-1"
               bind="{opts.bind}"
               type="text">
    </div>

    <script>
        const prefix = opts.prefix || '/'
        const $this = this;

        function toURL(value) {
            return value.replace(/[^a-zA-Z0-9\/]+/g, '-').toLowerCase();
        }

        this.on('mount', function () {
            opts.required && this.refs.input.setAttribute('required', 'required');

            // TODO: use fields from
            const element = App.$('input[bind="entry.title"]')

            element.on('keyup', function (el) {
                $this.$updateValue(prefix + el.target.value);
            });


            if (!$this.$getValue()) {
                $this.$updateValue(prefix);
            }

            this.update();
        });

        this.onInput = function (e) {
            e.target.value = toURL(e.target.value)
        }

        this.$updateValue = function (value) {
            $this.$setValue(toURL(value || prefix));

            this.update();
        }.bind(this);
    </script>
</field-autourl>
