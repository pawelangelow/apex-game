import Fastify from 'fastify';
import fastifyStatic from '@fastify/static';
import pg from 'pg';

const port = Number(process.env.PORT ?? 3000);
const pool = new pg.Pool({ connectionString: process.env.DATABASE_URL });
const app = Fastify({ logger: true });

app.get('/api/health', async () => {
  await pool.query('select 1');
  return { status: 'ok' };
});

// In production the server also serves the built client.
const clientDist = process.env.CLIENT_DIST;
if (clientDist) {
  await app.register(fastifyStatic, { root: clientDist });
  app.setNotFoundHandler((request, reply) => {
    if (request.url.startsWith('/api/')) {
      return reply.code(404).send({ error: 'Not found' });
    }
    return reply.sendFile('index.html');
  });
}

await app.listen({ port, host: '0.0.0.0' });
