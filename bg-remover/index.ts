import {removeBackground, Config} from "@imgly/background-removal-node"

const public_path = `file://${__dirname}/node_modules/@imgly/background-removal-node/dist/`;


let config: Config = {
    publicPath: public_path, // path to the wasm files
    model: "large",
    output: {
        format: "image/webp"
    }
};

// get the image as url
const image_src: string = process.argv[2];

// get the post url
const post_url: string = process.argv[3];

console.log("Remove background from", image_src, "and post to", post_url)

async function main() {
    const blob = await removeBackground(image_src, config)

    const formData = new FormData();
    formData.append('file', blob);
    const res = await fetch(post_url, {
        method: 'POST',
        body: formData
    })

    console.log("Response", res.status)
    process.exit(res.status === 200 ? 0 : 1);
}

main()
