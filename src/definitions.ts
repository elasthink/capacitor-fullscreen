export interface FullScreenPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
