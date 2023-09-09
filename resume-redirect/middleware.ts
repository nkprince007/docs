import { get } from '@vercel/edge-config';

export const config = {
    runtime: 'edge',
};

export default async function middleware(request: Request) {
    return Response.redirect(new URL(await get('targetURL') || request.url));
}