<template>
    <div>
        <nav class="controller">
            <button v-if="option.arrowsType" class="prev-btn" :class="{moving:option.arrowsType === 'animate'}" @click="changePage(prevIndex)"></button>
            <ul v-if="option.navbar">
                <li v-for="index in pageNum" @click="changePage(index)" :class="{current:option.highlight && index === currentPage}" :key="'controller-'+index" :data-index="index" class="controller-item"></li>
            </ul>
            <button v-if="option.arrowsType" class="next-btn" :class="{moving:option.arrowsType === 'animate'}" @click="changePage(nextIndex)"></button>
        </nav>
    </div>
</template>

<script>
export default {
  name: "page-controller",
  props: {
    pageNum: Number,
    currentPage: Number,
    option: {
      type: Object,
      default: {
        arrowsType: "animate",
        navbar: true,
        highlight: true,
        loop: true //是否开启滚动循环
      }
    }
  },
  methods: {
    changePage(index) {
      this.$emit("changePage", index);
    }
  },
  computed: {
    nextIndex() {
      if (this.currentPage === this.pageNum) {
        if (this.option.loop) {
          return 1;
        } else {
          return this.pageNum;
        }
      } else {
        return this.currentPage + 1;
      }
    },
    prevIndex() {
      if (this.currentPage === 1) {
        if (this.option.loop) {
          return this.pageNum;
        } else {
          return 1;
        }
      } else {
        return this.currentPage - 1;
      }
    }
  },
  created() {
    if (this.option.navbar === undefined) {
      this.option.navbar = true;
    }
  },
  mounted() {
    let _this = this;
    let timer = null;
    let start = 0;
    // 滚轮处理
    function scrollHandler(direction) {
      // 防止重复触发滚动事件
      if (timer != null) {
        return;
      }
      if (direction === "down") {
        _this.changePage(_this.nextIndex);
      } else {
        _this.changePage(_this.prevIndex);
      }
      timer = setTimeout(function() {
        clearTimeout(timer);
        timer = null;
      }, 300);
    }
    // if (Object.hasOwnProperty.call(window,'onmousewheel')) {
    if (Object.hasOwnProperty.call(window, "onmousewheel")) {
      // 监听滚轮事件
      window.addEventListener(
        "mousewheel",
        function(event) {
          // IE/Opera/Chrome
          let direction = event.wheelDelta > 0 ? "up" : "down";
          scrollHandler(direction);
        },
        false
      );
    } else {
      window.addEventListener(
        "DOMMouseScroll",
        function(event) {
          // Firefox
          let direction = event.detail > 0 ? "up" : "down";
          scrollHandler(direction);
        },
        false
      );
    }
    // 移动端触摸事件处理
    window.addEventListener("touchstart", function(event) {
      start = event.touches[0].clientY;
    });
    window.addEventListener("touchmove", function(event) {
      event.preventDefault();
    });
    window.addEventListener("touchend", function(event) {
      let spacing = event.changedTouches[0].clientY - start;
      let direction;
      if (spacing > 50) {
        direction = "up";
        scrollHandler(direction);
      } else if (spacing < -50) {
        direction = "down";
        scrollHandler(direction);
      }
    });
  }
};
</script>

<style scoped>
.controller {
  position: fixed;
  right: 20px;
  top: 50%;
  z-index: 99;
}
.controller ul {
  transform: translate3d(0, -50%, 0);
  list-style: none;
  margin: 0;
  padding: 0;
}
.controller-item {
  cursor: pointer;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  margin-top: 10px;
  background-color: rgba(255, 255, 255, 0.3);
  transition: background-color 0.3s ease 0s;
}
.controller-item:hover {
  background-color: rgba(255, 255, 255, 0.7);
}
.controller-item.current {
  background-color: rgba(255, 255, 255, 1);
}
.prev-btn,
.next-btn {
  cursor: pointer;
  display: block;
  text-align: center;
  width: 20px;
  height: 20px;
  position: fixed;
  left: 50%;
  margin-left: -10px;
  border: 4px solid #fff;
  background-color: transparent;
  outline: none;
}
.prev-btn {
  top: 80px;
  transform: rotate(-45deg);
  border-bottom-color: transparent;
  border-left-color: transparent;
}
.next-btn {
  bottom: 80px;
  transform: rotate(45deg);
  border-top-color: transparent;
  border-left-color: transparent;
}
.prev-btn.moving {
  animation: prev-up-down 0.7s linear 0s infinite;
}
.next-btn.moving {
  animation: next-up-down 0.7s linear 0s infinite;
}
@keyframes next-up-down {
  0% {
    transform: translate3d(0, 0, 0) rotate(45deg);
  }
  25% {
    transform: translate3d(0, 6px, 0) rotate(45deg);
  }
  50% {
    transform: translate3d(0, 0, 0) rotate(45deg);
  }
  75% {
    transform: translate3d(0, -6px, 0) rotate(45deg);
  }
  100% {
    transform: translate3d(0, 0, 0) rotate(45deg);
  }
}
@keyframes prev-up-down {
  0% {
    transform: translate3d(0, 0, 0) rotate(-45deg);
  }
  25% {
    transform: translate3d(0, -6px, 0) rotate(-45deg);
  }
  50% {
    transform: translate3d(0, 0, 0) rotate(-45deg);
  }
  75% {
    transform: translate3d(0, 6px, 0) rotate(-45deg);
  }
  100% {
    transform: translate3d(0, 0, 0) rotate(-45deg);
  }
}
</style>