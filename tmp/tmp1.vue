<template>
  <div>
    <p>{{ message }}</p>
    <button @click="increment">Increment</button>
  </div>
</template>

<script setup>

props: {
  initialCount: Number
}

let message = 'Hello, Vue 3!';

function increment() {
  message += '!';
}

onMounted(() => {
  console.log('Component is mounted');
});

</script>
