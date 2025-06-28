export interface Source{
    id: number;
    movieId: number;
    name: string;
    domain: string;
    type: 'END' | 'SEASON';
    part: number;
    baseUrl: string;
    downloadLink: string;
    isIframe: boolean;
    createdAt: string;
}