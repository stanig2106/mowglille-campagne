type ProfileImageOptions = {
  textColor?: string;
  backgroundColor?: string;
  fontFamily?: string;
  fontSize?: number;
  fontWeight?: string;
};

export class ProfileImage {

  private readonly name: string;
  private readonly textColor: string;
  private readonly backgroundColor: string;
  private readonly fontFamily: string;
  private readonly fontSize: number;
  private readonly fontWeight: string;

  constructor(name: string, options: ProfileImageOptions = {}) {
    this.name = name ?? "";
    this.textColor = options.textColor ?? "#ffffff";
    this.backgroundColor = options.backgroundColor ?? ProfileImage.get_random_color(name)
    this.fontFamily = options.fontFamily ?? "Arial";
    this.fontSize = options.fontSize ?? 40;
    this.fontWeight = options.fontWeight ?? "normal";
  }

  private static colors = [
    "#f44336", "#e91e63", "#9c27b0", "#673ab7",
    "#3f51b5", "#2196f3", "#009688", "#4caf50",
    "#ff9800", "#ff5722", "#795548", "#607d8b",
  ]

  public static new(name: string, options: ProfileImageOptions = {}) {
    return new ProfileImage(name, options);
  }

  private static get_random_color(str: string): string {
    let hash = 0;
    for (let i = 0; i < str.length; i++)
      hash = str.charCodeAt(i) + ((hash << 5) - hash);
    let index = Math.abs(hash % ProfileImage.colors.length);
    return ProfileImage.colors[index];
  }

  svg() { // returns svg as string
    return `<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='0 0 100 100' width='100' height='100' style='font-weight: ${this.fontWeight};'><rect width='100' height='100' x='0' y='0' fill='${this.backgroundColor}'></rect><text x='50%' y='50%' alignment-baseline='central' text-anchor='middle' font-family='${this.fontFamily}' font-size='${this.fontSize}' fill='${this.textColor}' dominant-baseline='middle'>${this.shortName()}</text></svg>`;
  }

  png() { // returns png as base64 string
    let canvas = document.createElement("canvas");
    let context = canvas.getContext("2d")!;
    canvas.width = 256;
    canvas.height = 256;
    context.fillStyle = this.backgroundColor;
    context.fillRect(0, 0, canvas.width, canvas.height);
    context.font = this.fontWeight + " 100px " + this.fontFamily;
    context.fillStyle = this.textColor;
    context.textAlign = "center";
    context.textBaseline = "middle";
    context.fillText(this.shortName(), canvas.width / 2, canvas.height / 2);
    return canvas.toDataURL("image/png");
  }

  private shortName() { // internal function, shortens the name to max. 2 characters
    let n_arr = this.name.split(" ");
    let n_res = "";
    if (n_arr.length <= 2)
      for (let i = 0; i < n_arr.length; i++)
        n_res += n_arr[i][0]?.toUpperCase();
    else
      for (let i = 0; i < 2; i++)
        n_res += n_arr[i][0]?.toUpperCase();
    return n_res;
  }
}
