async function selectPrevInfoForServer(bno){
    try {
        const resp = await fetch("/info/prev/"+bno);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}

async function selectNextInfoForServer(bno){
    try {
        const resp = await fetch("/info/next/"+bno);
        const result = await resp.json();
        return result;
    } catch (error) {
        console.log(error);
    }
}
