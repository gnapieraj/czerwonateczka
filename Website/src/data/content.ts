import lessonsData from "./generated/lessons.json";
import metaData from "./generated/meta.json";
import sourcesData from "./generated/sources.json";
import { lessonWebCopy } from "./site";

export type Localized = { pl: string; en: string };
export type Lesson = {
  id: string;
  order: number;
  hero: string;
  tone: "shadow" | "probono";
  title: Localized;
  subtitle: Localized;
  deadline: Localized;
  context: Localized;
  innerVoice: Localized;
  redFlags: Localized[];
  sourceIds: string[];
  awareness: {
    threat: Localized;
    minimize: Localized;
    practice: Localized;
    watchFor: Localized[];
  };
};

export type Source = {
  id: string;
  category: Localized;
  title: Localized;
  note: Localized;
  url: string;
};

export const lessons = (lessonsData as Lesson[])
  .map((lesson) => {
    const web = lessonWebCopy[lesson.id];
    if (!web) {
      throw new Error(`Brak copy WWW dla teczki ${lesson.id}`);
    }
    return { ...lesson, web };
  })
  .sort((a, b) => a.order - b.order);

export const sources = sourcesData as Source[];
export const contentMeta = metaData as {
  generatedAt: string;
  legalState: string;
  lessonCount: number;
  sourceCount: number;
};

export function sourcesFor(ids: string[]) {
  return sources.filter((source) => ids.includes(source.id));
}

export function lessonPath(lesson: (typeof lessons)[number]) {
  return `/wokanda/${lesson.web.slug}`;
}
