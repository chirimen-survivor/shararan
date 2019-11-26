// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require cocoon
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require toastr
//= require_tree .


(function() {
  'use strict';

  // フラッシュメッセージのfadeout
  $(function(){
      $('.flash_message').fadeOut(5000);
  });

})();

// 住所自動入力
$(window).ready( function() {
	$('#zip1').jpostal({
		postcode : [
			'#zip1',	//郵便番号1
			'#zip2' 	//郵便番号2
		],
		address : {
			'#adrs3'  : '%3',	//都道府県
			'#adrs4'  : '%4',	//市区町村
			'#adrs5'  : '%5',	//町域
			'#adrs6'  : '%6',	//大口事業所の番地
			'#adrs7'  : '%7',	//大口事業所の名称
			'#adrs8'  : '%8',	//都道府県カナ
			'#adrs9'  : '%9'	//市区町村カナ
		}
	});
});


(function($) {
  'use strict';

  var methods = {
    init: function(options) {
      return this.each(function() {
        this.self = $(this);

        methods.destroy.call(this.self);

        this.opt = $.extend(true, {}, $.fn.raty.defaults, options, this.self.data());

        methods._adjustCallback.call(this);
        methods._adjustNumber.call(this);
        methods._adjustHints.call(this);

        this.opt.score = methods._adjustedScore.call(this, this.opt.score);

        if (this.opt.starType !== 'img') {
          methods._adjustStarType.call(this);
        }

        methods._adjustPath.call(this);
        methods._createStars.call(this);

        if (this.opt.cancel) {
          methods._createCancel.call(this);
        }

        if (this.opt.precision) {
          methods._adjustPrecision.call(this);
        }

        methods._createScore.call(this);
        methods._apply.call(this, this.opt.score);
        methods._setTitle.call(this, this.opt.score);
        methods._target.call(this, this.opt.score);

        if (this.opt.readOnly) {
          methods._lock.call(this);
        } else {
          this.style.cursor = 'pointer';

          methods._binds.call(this);
        }
      });
    },

    _adjustCallback: function() {
      var options = ['number', 'readOnly', 'score', 'scoreName', 'target', 'path'];

      for (var i = 0; i < options.length; i++) {
        if (typeof this.opt[options[i]] === 'function') {
          this.opt[options[i]] = this.opt[options[i]].call(this);
        }
      }
    },

    _adjustedScore: function(score) {
      if (!score) {
        return score;
      }

      return methods._between(score, 0, this.opt.number);
    },

    _adjustHints: function() {
      if (!this.opt.hints) {
        this.opt.hints = [];
      }

      if (!this.opt.halfShow && !this.opt.half) {
        return;
      }

      var steps = this.opt.precision ? 10 : 2;

      for (var i = 0; i < this.opt.number; i++) {
        var group = this.opt.hints[i];

        if (Object.prototype.toString.call(group) !== '[object Array]') {
          group = [group];
        }

        this.opt.hints[i] = [];

        for (var j = 0; j < steps; j++) {
          var
            hint = group[j],
            last = group[group.length - 1];

          if (last === undefined) {
            last = null;
          }

          this.opt.hints[i][j] = hint === undefined ? last : hint;
        }
      }
    },

    _adjustNumber: function() {
      this.opt.number = methods._between(this.opt.number, 1, this.opt.numberMax);
    },

    _adjustPath: function() {
      this.opt.path = this.opt.path || '';

      if (this.opt.path && this.opt.path.charAt(this.opt.path.length - 1) !== '/') {
        this.opt.path += '/';
      }
    },

    _adjustPrecision: function() {
      this.opt.half = true;
    },

    _adjustStarType: function() {
      var replaces = ['cancelOff', 'cancelOn', 'starHalf', 'starOff', 'starOn'];

      this.opt.path = '';

      for (var i = 0; i < replaces.length; i++) {
        this.opt[replaces[i]] = this.opt[replaces[i]].replace('.', '-');
      }
    },

    _apply: function(score) {
      methods._fill.call(this, score);

      if (score) {
        if (score > 0) {
          this.score.val(score);
        }

        methods._roundStars.call(this, score);
      }
    },

    _between: function(value, min, max) {
      return Math.min(Math.max(parseFloat(value), min), max);
    },

    _binds: function() {
      if (this.cancel) {
        methods._bindOverCancel.call(this);
        methods._bindClickCancel.call(this);
        methods._bindOutCancel.call(this);
      }

      methods._bindOver.call(this);
      methods._bindClick.call(this);
      methods._bindOut.call(this);
    },

    _bindClick: function() {
      var that = this;

      that.stars.on('click.raty', function(evt) {
        var
          execute = true,
          score   = (that.opt.half || that.opt.precision) ? that.self.data('score') : (this.alt || $(this).data('alt'));

        if (that.opt.click) {
          execute = that.opt.click.call(that, +score, evt);
        }

        if (execute || execute === undefined) {
          if (that.opt.half && !that.opt.precision) {
            score = methods._roundHalfScore.call(that, score);
          }

          methods._apply.call(that, score);
        }
      });
    },

    _bindClickCancel: function() {
      var that = this;

      that.cancel.on('click.raty', function(evt) {
        that.score.removeAttr('value');

        if (that.opt.click) {
          that.opt.click.call(that, null, evt);
        }
      });
    },

    _bindOut: function() {
      var that = this;

      that.self.on('mouseleave.raty', function(evt) {
        var score = +that.score.val() || undefined;

        methods._apply.call(that, score);
        methods._target.call(that, score, evt);
        methods._resetTitle.call(that);

        if (that.opt.mouseout) {
          that.opt.mouseout.call(that, score, evt);
        }
      });
    },

    _bindOutCancel: function() {
      var that = this;

      that.cancel.on('mouseleave.raty', function(evt) {
        var icon = that.opt.cancelOff;

        if (that.opt.starType !== 'img') {
          icon = that.opt.cancelClass + ' ' + icon;
        }

        methods._setIcon.call(that, this, icon);

        if (that.opt.mouseout) {
          var score = +that.score.val() || undefined;

          that.opt.mouseout.call(that, score, evt);
        }
      });
    },

    _bindOver: function() {
      var
        that   = this,
        action = that.opt.half ? 'mousemove.raty' : 'mouseover.raty';

      that.stars.on(action, function(evt) {
        var score = methods._getScoreByPosition.call(that, evt, this);

        methods._fill.call(that, score);

        if (that.opt.half) {
          methods._roundStars.call(that, score, evt);
          methods._setTitle.call(that, score, evt);

          that.self.data('score', score);
        }

        methods._target.call(that, score, evt);

        if (that.opt.mouseover) {
          that.opt.mouseover.call(that, score, evt);
        }
      });
    },

    _bindOverCancel: function() {
      var that = this;

      that.cancel.on('mouseover.raty', function(evt) {
        var
          starOff = that.opt.path + that.opt.starOff,
          icon    = that.opt.cancelOn;

        if (that.opt.starType === 'img') {
          that.stars.attr('src', starOff);
        } else {
          icon = that.opt.cancelClass + ' ' + icon;

          that.stars.attr('class', starOff);
        }

        methods._setIcon.call(that, this, icon);
        methods._target.call(that, null, evt);

        if (that.opt.mouseover) {
          that.opt.mouseover.call(that, null);
        }
      });
    },

    _buildScoreField: function() {
      return $('<input />', { name: this.opt.scoreName, type: 'hidden' }).appendTo(this);
    },

    _createCancel: function() {
      var
        icon   = this.opt.path + this.opt.cancelOff,
        cancel = $('<' + this.opt.starType + ' />', { title: this.opt.cancelHint, 'class': this.opt.cancelClass });

      if (this.opt.starType === 'img') {
        cancel.attr({ src: icon, alt: 'x' });
      } else {
        // TODO: use $.data
        cancel.attr('data-alt', 'x').addClass(icon);
      }

      if (this.opt.cancelPlace === 'left') {
        this.self.prepend('&#160;').prepend(cancel);
      } else {
        this.self.append('&#160;').append(cancel);
      }

      this.cancel = cancel;
    },

    _createScore: function() {
      var score = $(this.opt.targetScore);

      this.score = score.length ? score : methods._buildScoreField.call(this);
    },

    _createStars: function() {
      for (var i = 1; i <= this.opt.number; i++) {
        var
          name  = methods._nameForIndex.call(this, i),
          attrs = { alt: i, src: this.opt.path + this.opt[name] };

        if (this.opt.starType !== 'img') {
          attrs = { 'data-alt': i, 'class': attrs.src }; // TODO: use $.data.
        }

        attrs.title = methods._getHint.call(this, i);

        $('<' + this.opt.starType + ' />', attrs).appendTo(this);

        if (this.opt.space) {
          this.self.append(i < this.opt.number ? '&#160;' : '');
        }
      }

      this.stars = this.self.children(this.opt.starType);
    },

    _error: function(message) {
      $(this).text(message);

      $.error(message);
    },

    _fill: function(score) {
      var hash = 0;

      for (var i = 1; i <= this.stars.length; i++) {
        var
          icon,
          star   = this.stars[i - 1],
          turnOn = methods._turnOn.call(this, i, score);

        if (this.opt.iconRange && this.opt.iconRange.length > hash) {
          var irange = this.opt.iconRange[hash];

          icon = methods._getRangeIcon.call(this, irange, turnOn);

          if (i <= irange.range) {
            methods._setIcon.call(this, star, icon);
          }

          if (i === irange.range) {
            hash++;
          }
        } else {
          icon = this.opt[turnOn ? 'starOn' : 'starOff'];

          methods._setIcon.call(this, star, icon);
        }
      }
    },

    _getFirstDecimal: function(number) {
      var
        decimal = number.toString().split('.')[1],
        result  = 0;

      if (decimal) {
        result = parseInt(decimal.charAt(0), 10);

        if (decimal.slice(1, 5) === '9999') {
          result++;
        }
      }

      return result;
    },

    _getRangeIcon: function(irange, turnOn) {
      return turnOn ? irange.on || this.opt.starOn : irange.off || this.opt.starOff;
    },

    _getScoreByPosition: function(evt, icon) {
      var score = parseInt(icon.alt || icon.getAttribute('data-alt'), 10);

      if (this.opt.half) {
        var
          size    = methods._getWidth.call(this),
          percent = parseFloat((evt.pageX - $(icon).offset().left) / size);

        score = score - 1 + percent;
      }

      return score;
    },

    _getHint: function(score, evt) {
      if (score !== 0 && !score) {
        return this.opt.noRatedMsg;
      }

      var
        decimal = methods._getFirstDecimal.call(this, score),
        integer = Math.ceil(score),
        group   = this.opt.hints[(integer || 1) - 1],
        hint    = group,
        set     = !evt || this.move;

      if (this.opt.precision) {
        if (set) {
          decimal = decimal === 0 ? 9 : decimal - 1;
        }

        hint = group[decimal];
      } else if (this.opt.halfShow || this.opt.half) {
        decimal = set && decimal === 0 ? 1 : decimal > 5 ? 1 : 0;

        hint = group[decimal];
      }

      return hint === '' ? '' : hint || score;
    },

    _getWidth: function() {
      var width = this.stars[0].width || parseFloat(this.stars.eq(0).css('font-size'));

      if (!width) {
        methods._error.call(this, 'Could not get the icon width!');
      }

      return width;
    },

    _lock: function() {
      var hint = methods._getHint.call(this, this.score.val());

      this.style.cursor = '';
      this.title        = hint;

      this.score.prop('readonly', true);
      this.stars.prop('title', hint);

      if (this.cancel) {
        this.cancel.hide();
      }

      this.self.data('readonly', true);
    },

    _nameForIndex: function(i) {
      return this.opt.score && this.opt.score >= i ? 'starOn' : 'starOff';
    },

    _resetTitle: function() {
      for (var i = 0; i < this.opt.number; i++) {
        this.stars[i].title = methods._getHint.call(this, i + 1);
      }
    },

    _roundHalfScore: function(score) {
      var
        integer = parseInt(score, 10),
        decimal = methods._getFirstDecimal.call(this, score);

      if (decimal !== 0) {
        decimal = decimal > 5 ? 1 : 0.5;
      }

      return integer + decimal;
    },

    _roundStars: function(score, evt) {
      var
        decimal = (score % 1).toFixed(2),
        name ;

      if (evt || this.move) {
        name = decimal > 0.5 ? 'starOn' : 'starHalf';
      } else if (decimal > this.opt.round.down) { // Up: [x.76 .. x.99]
        name = 'starOn';

        if (this.opt.halfShow && decimal < this.opt.round.up) { // Half: [x.26 .. x.75]
          name = 'starHalf';
        } else if (decimal < this.opt.round.full) { // Down: [x.00 .. x.5]
          name = 'starOff';
        }
      }

      if (name) {
        var
          icon = this.opt[name],
          star = this.stars[Math.ceil(score) - 1];

        methods._setIcon.call(this, star, icon);
      } // Full down: [x.00 .. x.25]
    },

    _setIcon: function(star, icon) {
      star[this.opt.starType === 'img' ? 'src' : 'className'] = this.opt.path + icon;
    },

    _setTarget: function(target, score) {
      if (score) {
        score = this.opt.targetFormat.toString().replace('{score}', score);
      }

      if (target.is(':input')) {
        target.val(score);
      } else {
        target.html(score);
      }
    },

    _setTitle: function(score, evt) {
      if (score) {
        var
          integer = parseInt(Math.ceil(score), 10),
          star    = this.stars[integer - 1];

        star.title = methods._getHint.call(this, score, evt);
      }
    },

    _target: function(score, evt) {
      if (this.opt.target) {
        var target = $(this.opt.target);

        if (!target.length) {
          methods._error.call(this, 'Target selector invalid or missing!');
        }

        var mouseover = evt && evt.type === 'mouseover';

        if (score === undefined) {
          score = this.opt.targetText;
        } else if (score === null) {
          score = mouseover ? this.opt.cancelHint : this.opt.targetText;
        } else {
          if (this.opt.targetType === 'hint') {
            score = methods._getHint.call(this, score, evt);
          } else if (this.opt.precision) {
            score = parseFloat(score).toFixed(1);
          }

          var mousemove = evt && evt.type === 'mousemove';

          if (!mouseover && !mousemove && !this.opt.targetKeep) {
            score = this.opt.targetText;
          }
        }

        methods._setTarget.call(this, target, score);
      }
    },

    _turnOn: function(i, score) {
      return this.opt.single ? (i === score) : (i <= score);
    },

    _unlock: function() {
      this.style.cursor = 'pointer';
      this.removeAttribute('title');

      this.score.removeAttr('readonly');

      this.self.data('readonly', false);

      for (var i = 0; i < this.opt.number; i++) {
        this.stars[i].title = methods._getHint.call(this, i + 1);
      }

      if (this.cancel) {
        this.cancel.css('display', '');
      }
    },

    cancel: function(click) {
      return this.each(function() {
        var self = $(this);

        if (self.data('readonly') !== true) {
          methods[click ? 'click' : 'score'].call(self, null);

          this.score.removeAttr('value');
        }
      });
    },

    click: function(score) {
      return this.each(function() {
        if ($(this).data('readonly') !== true) {
          score = methods._adjustedScore.call(this, score);

          methods._apply.call(this, score);

          if (this.opt.click) {
            this.opt.click.call(this, score, $.Event('click'));
          }

          methods._target.call(this, score);
        }
      });
    },

    destroy: function() {
      return this.each(function() {
        var
          self = $(this),
          raw  = self.data('raw');

        if (raw) {
          self.off('.raty').empty().css({ cursor: raw.style.cursor }).removeData('readonly');
        } else {
          self.data('raw', self.clone()[0]);
        }
      });
    },

    getScore: function() {
      var
        score = [],
        value ;

      this.each(function() {
        value = this.score.val();

        score.push(value ? +value : undefined);
      });

      return (score.length > 1) ? score : score[0];
    },

    move: function(score) {
      return this.each(function() {
        var
          integer  = parseInt(score, 10),
          decimal  = methods._getFirstDecimal.call(this, score);

        if (integer >= this.opt.number) {
          integer = this.opt.number - 1;
          decimal = 10;
        }

        var
          width   = methods._getWidth.call(this),
          steps   = width / 10,
          star    = $(this.stars[integer]),
          percent = star.offset().left + steps * decimal,
          evt     = $.Event('mousemove', { pageX: percent });

        this.move = true;

        star.trigger(evt);

        this.move = false;
      });
    },

    readOnly: function(readonly) {
      return this.each(function() {
        var self = $(this);

        if (self.data('readonly') !== readonly) {
          if (readonly) {
            self.off('.raty').children(this.opt.starType).off('.raty');

            methods._lock.call(this);
          } else {
            methods._binds.call(this);
            methods._unlock.call(this);
          }

          self.data('readonly', readonly);
        }
      });
    },

    reload: function() {
      return methods.set.call(this, {});
    },

    score: function() {
      var self = $(this);

      return arguments.length ? methods.setScore.apply(self, arguments) : methods.getScore.call(self);
    },

    set: function(options) {
      return this.each(function() {
        $(this).raty($.extend({}, this.opt, options));
      });
    },

    setScore: function(score) {
      return this.each(function() {
        if ($(this).data('readonly') !== true) {
          score = methods._adjustedScore.call(this, score);

          methods._apply.call(this, score);
          methods._target.call(this, score);
        }
      });
    }
  };

  $.fn.raty = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method) {
      return methods.init.apply(this, arguments);
    } else {
      $.error('Method ' + method + ' does not exist!');
    }
  };

  $.fn.raty.defaults = {
    cancel:       false,
    cancelClass:  'raty-cancel',
    cancelHint:   'Cancel this rating!',
    cancelOff:    'cancel-off.png',
    cancelOn:     'cancel-on.png',
    cancelPlace:  'left',
    click:        undefined,
    half:         false,
    halfShow:     true,
    hints:        ['bad', 'poor', 'regular', 'good', 'gorgeous'],
    iconRange:    undefined,
    mouseout:     undefined,
    mouseover:    undefined,
    noRatedMsg:   'Not rated yet!',
    number:       5,
    numberMax:    20,
    path:         undefined,
    precision:    false,
    readOnly:     false,
    round:        { down: 0.25, full: 0.6, up: 0.76 },
    score:        undefined,
    scoreName:    'score',
    single:       false,
    space:        true,
    starHalf:     'star-half.png',
    starOff:      'star-off.png',
    starOn:       'star-on.png',
    starType:     'img',
    target:       undefined,
    targetFormat: '{score}',
    targetKeep:   false,
    targetScore:  undefined,
    targetText:   '',
    targetType:   'hint'
  };
})(jQuery);


var Jpostal = {};

Jpostal.Database = function () {
    "use strict";

    this.address = [];    // database cache
    this.map     = {};
    this.url     = {
        'http'  : '//jpostal-1006.appspot.com/json/',
        'https' : '//jpostal-1006.appspot.com/json/'
    };
};

Jpostal.Database.prototype.find = function (i_postcode) {
    "use strict";

    var address = [];

    this.address.forEach(function (eachAddress) {
        if (eachAddress[0] === '_' + i_postcode) {
            address = eachAddress;
        }
    });

    return address;
};

Jpostal.Database.prototype.get = function (i_postcode) {
    "use strict";

    //    --------------------------------------------------
    //    i_postcode    find()    find()    result
    //                1234567    123
    //    --------------------------------------------------
    //    1             -        -        defaults
    //    12            -        -        defaults
    //    123           -        Y        find( '123' )
    //    123           -        N        defaults
    //    1234          -        Y        find( '123' )
    //    1234          -        N        defaults
    //    1234567       Y        -        find( '1234567' )
    //    1234567       N        Y        find( '123' )
    //    1234567       N        N        defaults
    //    --------------------------------------------------
    var defaults = ['', '', '', '', '', '', '', '', ''],
        address,
        head3;

    switch (i_postcode.length) {
    case 3:
    case 4:
    case 5:
    case 6:
        head3 = i_postcode.substr(0, 3);
        address = this.find(head3);
        address = $.extend(defaults, address);
        break;

    case 7:
        address = this.find(i_postcode);
        if (address.length === 0) {
            head3 = i_postcode.substr(0, 3);
            address = this.find(head3);
        }
        address = $.extend(defaults, address);
        break;

    default:
        address = defaults;
        break;
    }

    return address;
};

Jpostal.Database.prototype.getUrl = function (i_head3) {
    "use strict";

    var url = '';

    switch (this.getProtocol()) {
    case 'http:':
        url = this.url.http;
        break;

    case 'https:':
        url = this.url.https;
        break;
    }
    url = url + i_head3 + '.json';

    try {
        url = url + '?referer=' + encodeURIComponent(window.location.href);
    } catch (e) {}

    return url;
};

Jpostal.Database.prototype.request = function (i_postcode, i_callback) {
    "use strict";

    var head3,
        url,
        options;

    head3 = i_postcode.substr(0, 3);

    if (i_postcode.length <= 2 || this.getStatus(head3) !== 'none' || head3.match(/\D/)) {
        return false;
    }
    this.setStatus(head3, 'waiting');

    url = this.getUrl(head3);

    options = {
        async         : true,
        dataType      : 'jsonp',
        jsonpCallback : 'jQuery_jpostal_callback',
        type          : 'GET',
        url           : url,
        success       : function () {    // function(i_data, i_dataType
            i_callback();
        },
        timeout : 5000    // msec
    };
    this.ajax(options);
    return true;
};

Jpostal.Database.prototype.ajax = function (options) {
    "use strict";

    $.ajax(options);
};

Jpostal.Database.prototype.save = function (i_data) {
    "use strict";

    var that = this;

    i_data.forEach(function (rcd) {
        var postcode = rcd[0];

        if (that.map[postcode] === undefined) {
            that.address.push(rcd);
            that.map[postcode] = {state : 'complete', time : 0};
        } else if (that.map[postcode].state === 'waiting') {
            that.address.push(rcd);
            that.map[postcode].state = 'complete';
        }
    });
};

Jpostal.Database.prototype.getStatus = function (i_postcode) {
    "use strict";

    //    --------------------------------------------------
    //    #    ['_001']    ..state        .time        result
    //    --------------------------------------------------
    //    1     =undefined    -            -            none
    //    2    !=undefined    'complete'    -           complete
    //    3    !=undefined    'waiting'    <5sec        waiting
    //    4    !=undefined    'waiting'    >=5sec       none
    //    --------------------------------------------------
    var st = '',
        postcode = '_' + i_postcode,
        t_ms;

    if (this.map[postcode] === undefined) {
        // # 1
        st = 'none';

    } else if ('complete' === this.map[postcode].state) {
        // # 2
        st = 'complete';

    } else {
        t_ms = this.getTime() - this.map[postcode].time;
        if (t_ms < 5000) {
            // # 3
            st = 'waiting';

        } else {
            // # 4
            st = 'none';
        }
    }

    return st;
};

Jpostal.Database.prototype.setStatus = function (i_postcode) {
    "use strict";

    var postcode = '_' + i_postcode;

    if (this.map[postcode] === undefined) {
        this.map[postcode] = {
            state : 'waiting',
            time  : 0
        };
    }

    this.map[postcode].time = this.getTime();
};

Jpostal.Database.prototype.getProtocol = function () {
    "use strict";

    return window.location.protocol;
};

Jpostal.Database.prototype.getTime = function () {
    "use strict";

    return (new Date()).getTime();
};

(function () {
    "use strict";

    var instance;

    Jpostal.Database.getInstance = function () {
        if (instance === undefined) {
            instance = new Jpostal.Database();
        }
        return instance;
    };
}());

Jpostal.Jpostal = function (i_JposDb) {
    "use strict";

    this.address  = '';
    this.jposDb   = i_JposDb;
    this.options  = {};
    this.postcode = '';
    this.minLen   = 3;
};

Jpostal.Jpostal.prototype.displayAddress = function () {
    "use strict";

    var that = this;

    if (this.postcode === '000info') {
        this.address[2] += ' ' + this.getScriptSrc();
    }

    Object.keys(this.options.address).forEach(function (key) {
        var format = that.options.address[key],
            value = that.formatAddress(format, that.address);

        if (that.isSelectTagForPrefecture(key, format)) {
            that.setSelectTagForPrefecture(key, value);
        } else {
            $(key).val(value);
            that.trigger(key);
        }
    });
};

Jpostal.Jpostal.prototype.isSelectTagForPrefecture = function (i_key, i_fmt) {
    "use strict";

    // 都道府県のSELECTタグか？
    var f;

    switch (i_fmt) {
    case '%3':
    case '%p':
    case '%prefecture':
        if ($(i_key).get(0).tagName.toUpperCase() === 'SELECT') {
            f = true;
        } else {
            f = false;
        }
        break;

    default:
        f = false;
        break;
    }
    return f;
};

Jpostal.Jpostal.prototype.setSelectTagForPrefecture = function (i_key, i_value) {
    "use strict";

    var value,
        el;

    // 都道府県のSELECTタグ
    // ケース1: <option value="東京都">東京都</option>
    $(i_key).val(i_value);
    if ($(i_key).val() === i_value) {
        this.trigger(i_key);
        return;
    }

    // ケース2: valueが数値(自治体コードの場合が多い)
    //    テキストが「北海道」を含むかどうかで判断する
    //    <option value="01">北海道(01)</option>
    //    <option value="1">1.北海道</option>
    value = '';
    el = $(i_key)[0];
    Object.keys(el.options).forEach(function (i) {
        var p = String(el.options[i].text).indexOf(i_value);
        if (0 <= p) {
            value = el.options[i].value;
        }
    });

    if (value !== '') {
        $(i_key).val(value);
        this.trigger(i_key);
    }

};

Jpostal.Jpostal.prototype.trigger = function (i_key) {
    "use strict";

    if (this.options.trigger === undefined || this.options.trigger[i_key] === undefined || this.options.trigger[i_key] === false) {
        return;
    }
    $(i_key).trigger("change");
};

Jpostal.Jpostal.prototype.formatAddress = function (i_fmt, i_address) {
    "use strict";

    var s = i_fmt,
        that = this;

    s = s.replace(/%3|%p|%prefecture/, i_address[1]);
    s = s.replace(/%4|%c|%city/,       i_address[2]);
    s = s.replace(/%5|%t|%town/,       i_address[3]);
    s = s.replace(/%6|%a|%address/,    i_address[4]);
    s = s.replace(/%7|%n|%name/,       i_address[5]);

    s = s.replace(/%8/,  i_address[6]);
    s = s.replace(/%9/,  i_address[7]);
    s = s.replace(/%10/, i_address[8]);

    s = s.replace(/%([ASHKV]+)8/, function (match, p1) {
        return that.mb_convert_kana(i_address[6], p1);
    });
    s = s.replace(/%([ASHKV]+)9/, function (match, p1) {
        return that.mb_convert_kana(i_address[7], p1);
    });
    s = s.replace(/%([ASHKV]+)10/, function (match, p1) {
        return that.mb_convert_kana(i_address[8], p1);
    });

    return s;
};

Jpostal.Jpostal.prototype.mb_convert_kana = function (i_str, i_option) {
    "use strict";

    var str = i_str,
        i,
        o,
        funcs;

    function tr(i_str, map) {
        var reg = new RegExp("(" + Object.keys(map).join("|") + ")", "g");

        return i_str.replace(reg, function (s) {
            return map[s];
        });
    }

    funcs = {
        A: function (i_str) {
            var reg = /[A-Za-z0-9!#\$%&\(\)\*\+,\-\.\/:;<=>\?@\[\]\^_`\{\|\}]/g,
                s;

            s = i_str.replace(reg, function (s) {
                return String.fromCharCode(s.charCodeAt(0) + 65248);
            });

            return s;
        },
        S: function (i_str) {
            return i_str.replace(/\u0020/g, '\u3000');
        },
        H: function (i_str) {
            var map = {
                "ｱ": "あ",
                "ｲ": "い",
                "ｳ": "う",
                "ｴ": "え",
                "ｵ": "お",
                "ｶ": "か",
                "ｷ": "き",
                "ｸ": "く",
                "ｹ": "け",
                "ｺ": "こ",
                "ｻ": "さ",
                "ｼ": "し",
                "ｽ": "す",
                "ｾ": "せ",
                "ｿ": "そ",
                "ﾀ": "た",
                "ﾁ": "ち",
                "ﾂ": "つ",
                "ﾃ": "て",
                "ﾄ": "と",
                "ﾅ": "な",
                "ﾆ": "に",
                "ﾇ": "ぬ",
                "ﾈ": "ね",
                "ﾉ": "の",
                "ﾊ": "は",
                "ﾋ": "ひ",
                "ﾌ": "ふ",
                "ﾍ": "へ",
                "ﾎ": "ほ",
                "ﾏ": "ま",
                "ﾐ": "み",
                "ﾑ": "む",
                "ﾒ": "め",
                "ﾓ": "も",
                "ﾔ": "や",
                "ﾕ": "ゆ",
                "ﾖ": "よ",
                "ﾗ": "ら",
                "ﾘ": "り",
                "ﾙ": "る",
                "ﾚ": "れ",
                "ﾛ": "ろ",
                "ﾜ": "わ",
                "ｦ": "を",
                "ﾝ": "ん",
                "ｧ": "ぁ",
                "ｨ": "ぃ",
                "ｩ": "ぅ",
                "ｪ": "ぇ",
                "ｫ": "ぉ",
                "ｯ": "っ",
                "ｬ": "ゃ",
                "ｭ": "ゅ",
                "ｮ": "ょ",
                "｡": "。",
                "､": "、",
                "ｰ": "ー",
                "｢": "「",
                "｣": "」",
                "･": "・",
                "ﾞ": "゛",
                "ﾟ": "゜"
            };
            return tr(i_str, map);
        },
        K: function (i_str) {
            var map = {
                "ｱ": "ア",
                "ｲ": "イ",
                "ｳ": "ウ",
                "ｴ": "エ",
                "ｵ": "オ",
                "ｶ": "カ",
                "ｷ": "キ",
                "ｸ": "ク",
                "ｹ": "ケ",
                "ｺ": "コ",
                "ｻ": "サ",
                "ｼ": "シ",
                "ｽ": "ス",
                "ｾ": "セ",
                "ｿ": "ソ",
                "ﾀ": "タ",
                "ﾁ": "チ",
                "ﾂ": "ツ",
                "ﾃ": "テ",
                "ﾄ": "ト",
                "ﾅ": "ナ",
                "ﾆ": "ニ",
                "ﾇ": "ヌ",
                "ﾈ": "ネ",
                "ﾉ": "ノ",
                "ﾊ": "ハ",
                "ﾋ": "ヒ",
                "ﾌ": "フ",
                "ﾍ": "ヘ",
                "ﾎ": "ホ",
                "ﾏ": "マ",
                "ﾐ": "ミ",
                "ﾑ": "ム",
                "ﾒ": "メ",
                "ﾓ": "モ",
                "ﾔ": "ヤ",
                "ﾕ": "ユ",
                "ﾖ": "ヨ",
                "ﾗ": "ラ",
                "ﾘ": "リ",
                "ﾙ": "ル",
                "ﾚ": "レ",
                "ﾛ": "ロ",
                "ﾜ": "ワ",
                "ｦ": "ヲ",
                "ﾝ": "ン",
                "ｧ": "ァ",
                "ｨ": "ィ",
                "ｩ": "ゥ",
                "ｪ": "ェ",
                "ｫ": "ォ",
                "ｯ": "ッ",
                "ｬ": "ャ",
                "ｭ": "ュ",
                "ｮ": "ョ",
                "｡": "。",
                "､": "、",
                "ｰ": "ー",
                "｢": "「",
                "｣": "」",
                "･": "・",
                "ﾞ": "゛",
                "ﾟ": "゜"
            };
            return tr(i_str, map);
        },
        V: function (i_str) {
            var map = {
                "か゛": "が",
                "き゛": "ぎ",
                "く゛": "ぐ",
                "け゛": "げ",
                "こ゛": "ご",
                "さ゛": "ざ",
                "し゛": "じ",
                "す゛": "ず",
                "せ゛": "ぜ",
                "そ゛": "ぞ",
                "た゛": "だ",
                "ち゛": "ぢ",
                "つ゛": "づ",
                "て゛": "で",
                "と゛": "ど",
                "は゛": "ば",
                "ひ゛": "び",
                "ふ゛": "ぶ",
                "へ゛": "べ",
                "ほ゛": "ぼ",
                "は゜": "ぱ",
                "ひ゜": "ぴ",
                "ふ゜": "ぷ",
                "へ゜": "ぺ",
                "ほ゜": "ぽ",

                "カ゛": "ガ",
                "キ゛": "ギ",
                "ク゛": "グ",
                "ケ゛": "ゲ",
                "コ゛": "ゴ",
                "サ゛": "ザ",
                "シ゛": "ジ",
                "ス゛": "ズ",
                "セ゛": "ゼ",
                "ソ゛": "ゾ",
                "タ゛": "ダ",
                "チ゛": "ヂ",
                "ツ゛": "ヅ",
                "テ゛": "デ",
                "ト゛": "ド",
                "ハ゛": "バ",
                "ヒ゛": "ビ",
                "フ゛": "ブ",
                "ヘ゛": "ベ",
                "ホ゛": "ボ",
                "ハ゜": "パ",
                "ヒ゜": "ピ",
                "フ゜": "プ",
                "ヘ゜": "ペ",
                "ホ゜": "ポ"
            };
            return tr(i_str, map);
        }
    };

    for (i = 0; i < i_option.length; i += 1) {
        o = i_option[i];
        str = funcs[o](str);
    }

    return str;
};

Jpostal.Jpostal.prototype.getScriptSrc = function () {
    "use strict";

    var src = '',
        el_arr,
        i,
        n,
        el_src;

    el_arr = document.getElementsByTagName('script');
    n = el_arr.length;
    for (i = 0; i < n; i += 1) {
        el_src = el_arr[i].src;
        if (0 <= el_src.indexOf("jquery.jpostal.js")) {
            src = el_src;
            break;
        }
    }

    return src;
};

Jpostal.Jpostal.prototype.init = function (i_options) {
    "use strict";

    if (i_options.postcode === undefined) {
        throw new Error('postcode undefined');
    }
    if (i_options.address === undefined) {
        throw new Error('address undefined');
    }

    this.options.postcode = [];
    if (typeof i_options.postcode === 'string') {
        this.options.postcode.push(i_options.postcode);
    } else {
        this.options.postcode = i_options.postcode;
    }

    this.options.address = i_options.address;

    if (i_options.url !== undefined) {
        this.jposDb.url = i_options.url;
    }

    this.options.trigger = {};
    if (i_options.trigger !== undefined) {
        this.options.trigger = i_options.trigger;
    }
};

Jpostal.Jpostal.prototype.main = function () {
    "use strict";

    var that,
        f;

    this.scanPostcode();
    if (this.postcode.length < this.minLen) {
        // git hub issue #4: 郵便番号欄が0～2文字のとき、住所欄を空欄にせず、入力内容を維持してほしい 
        return;
    }

    that = this;
    f = this.jposDb.request(this.postcode, function () {
        that.callback();
    });
    if (!f) {
        this.callback();
    }
};

Jpostal.Jpostal.prototype.callback = function () {
    "use strict";

    this.address = this.jposDb.get(this.postcode);
    this.displayAddress();
};

Jpostal.Jpostal.prototype.scanPostcode = function () {
    "use strict";

    var s = '',
        s3,
        s4;

    switch (this.options.postcode.length) {
    case 0:
        break;

    case 1:
        //    github issue #8: 1つ目を空欄、2つ目を「001」としても、「001」として北海道札幌市を表示してしまう
        //    ----------------------------------------
        //    case    postcode    result
        //    ----------------------------------------
        //    1        ''            ''
        //    1        12            ''
        //    2        123           123
        //    2        123-          123
        //    2        123-4         123
        //    3        123-4567      1234567
        //    2        1234          123
        //    4        1234567       1234567
        //    ----------------------------------------
        s = String($(this.options.postcode[0]).val());
        if (0 <= s.search(/^([0-9]{3})([0-9A-Za-z]{4})/)) {
            // case 4
            s = s.substr(0, 7);
        } else if (0 <= s.search(/^([0-9]{3})-([0-9A-Za-z]{4})/)) {
            // case 3
            s = s.substr(0, 3) + s.substr(4, 4);
        } else if (0 <= s.search(/^([0-9]{3})/)) {
            // case 2
            s = s.substr(0, 3);
        } else {
            // case 1
            s = '';
        }
        break;

    case 2:
        //    github issue #8: 1つ目を空欄、2つ目を「001」としても、「001」として北海道札幌市を表示してしまう
        //    ----------------------------------------
        //    case    post1    post2    result
        //    ----------------------------------------
        //    1        ''        ---        ''
        //    1        12        ---        ''
        //    2        123        ''        123
        //    2        123        4         123
        //    3        123        4567      1234567
        //    ----------------------------------------
        s3 = String($(this.options.postcode[0]).val());
        s4 = String($(this.options.postcode[1]).val());
        if (0 <= s3.search(/^[0-9]{3}$/)) {
            if (0 <= s4.search(/^[0-9A-Za-z]{4}$/)) {
                // case 3
                s = s3 + s4;
            } else {
                // case 2
                s = s3;
            }
        } else {
            // case 1
            s = '';
        }
        break;
    }

    this.postcode = s;
};

//    MEMO: For the following reason, JposDb was put on the global scope, not local scope.
//    ---------------------------------------------------------------------
//     data file    callback            JposDb scope
//    ---------------------------------------------------------------------
//    001.js        JposDb.save            global scope
//    001.js.php    $_GET['callback']    local scopde for function($){}
//    ---------------------------------------------------------------------
window.jQuery_jpostal_callback = function (i_data) {
    "use strict";

    Jpostal.Database.getInstance().save(i_data);
};


(function (factory) {
    "use strict";

    if (typeof module === "object" && typeof module.exports === "object") {
        module.exports = factory(require("jquery"), window, document);
    } else {
        factory(jQuery, window, document);
    }
//}(function ($, window, document, undefined) {
}(function ($) {
    "use strict";

    $.fn.jpostal = function (i_options) {
        var Jpos,
            selector;

        Jpos = new Jpostal.Jpostal(Jpostal.Database.getInstance());
        Jpos.init(i_options);

        if (typeof i_options.click === 'string' && i_options.click !== '') {
            $(i_options.click).bind('click', function () {
                Jpos.main();
            });
        } else {
            selector = Jpos.options.postcode[0];
            $(selector).bind('keyup change', function () {
                Jpos.main();
            });

            if (1 <= Jpos.options.postcode.length) {
                selector = Jpos.options.postcode[1];
                $(selector).bind('keyup change', function () {
                    Jpos.main();
                });
            }
        }
    };

}));
