import { defineCodeRunnersSetup } from '@slidev/types'

export default defineCodeRunnersSetup(() => {
  return {
    async lua(code) {
      const res = await fetch('http://localhost:8080/run-lua', {
        method: 'POST',
        headers: {
          'Content-Type': 'text/plain',
        },
        body: code,
      });

      const output = await res.text()
      return { html: output };
    }
  }
});

