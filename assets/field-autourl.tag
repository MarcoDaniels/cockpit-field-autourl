<field-autourl>
    <style>
        [ref="input"][type=text] {
            padding-right: 30px !important;
        }

        .field-text-container span {
            position: absolute;
            top: 50%;
            right: 0;
            font-family: monospace;
            transform: translateY(-50%) scale(.9);
        }

        div.autourl-field-error {
            color: red;
        }
    </style>

    <div class="uk-position-relative field-text-container">
        <input ref="input"
               oninput="{onInput}"
               class="uk-width-1-1"
               bind="{opts.bind}"
               type="text">
        <span class="uk-text-muted" ref="lengthIndicator"></span>
    </div>

    <div class="uk-text-small uk-margin-small-top autourl-field-error" if="{error}" title="Error">
        {error}
    </div>

    <script>
        const $this = this;

        function buildURL(value) {
            return value.replace(/[^a-zA-Z0-9\/]+/g, '-').toLowerCase();
        }

        this.on('mount', function () {
            opts.required && this.refs.input.setAttribute('required', 'required');

            opts.pattern.split('/').map((field, key) => {
                if (field.includes(':')) {
                    const element = App.$('cp-field[bind="entry.' + field.substring(1) + '"]');
                    if (element.length && element[0].getAttribute('type') === 'text') {
                        element.on('keyup', function (el) {
                            $this.updateValue(key, el.target.value);
                            $this.update();
                        });
                    } else {
                        this.error = 'field "' + field + '" in pattern does not exist';
                    }
                }
            })

            this.updateLengthIndicator();
            this.update();
        });

        this.onInput = function (e) {
            e.target.value = buildURL(e.target.value);
        };

        this.updateValue = function (key, value) {
            if (value) {
                const current = ($this.$getValue() || opts.pattern).split('/');

                current[key] = value;

                const result = current.filter(t => !t.includes(':')).join('/');

                $this.$setValue(buildURL(result));
            }

            this.updateLengthIndicator();
            this.update();
        };

        this.updateLengthIndicator = function () {
            this.refs.lengthIndicator.innerText = Math.abs(0 - this.refs.input.value.length);
        };
    </script>
</field-autourl>
