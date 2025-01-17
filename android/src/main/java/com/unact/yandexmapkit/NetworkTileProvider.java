package com.unact.yandexmapkit;

import androidx.annotation.NonNull;

import com.yandex.mapkit.RawTile;
import com.yandex.mapkit.TileId;
import com.yandex.mapkit.Version;
import com.yandex.mapkit.tiles.TileProvider;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;
import java.util.Objects;

public class NetworkTileProvider implements TileProvider {
    private final String baseUrl;
    private final Map<String, String> headers;

    NetworkTileProvider(String baseUrl, Map<String, String> headers) {
        this.baseUrl = baseUrl;
        this.headers = headers;
    }

    public String getBaseUrl() {
        return baseUrl;
    }

    @NonNull
    @Override
    public RawTile load(@NonNull TileId tileId, @NonNull Version version, @NonNull String etag) {
        int x = tileId.getX();
        int y = tileId.getY();
        int z = tileId.getZ() + 1;

        String formattedUrl = baseUrl.replaceAll("\\{ *([x_-]+) *\\}", String.valueOf(x))
                .replaceAll("\\{ *([y_-]+) *\\}", String.valueOf(y))
                .replaceAll("\\{ *([z_-]+) *\\}", String.valueOf(z));

        try {
            byte[] data = downloadFile(new URL(formattedUrl));
            return new RawTile(version, etag, RawTile.State.OK, data);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new RawTile();
    }

    private byte[] downloadFile(URL url) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        InputStream is = null;
        try {
            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.setRequestMethod("GET");
            for (Map.Entry<String, String> entry : headers.entrySet()) {
                urlConnection.setRequestProperty(entry.getKey(), entry.getValue());
            }
            urlConnection.connect();
            is = urlConnection.getInputStream();
            byte[] byteChunk = new byte[4096];
            int n;
            while ( (n = is.read(byteChunk)) > 0 ) {
                baos.write(byteChunk, 0, n);
            }
        }
        catch (IOException e) {
            System.err.printf ("Failed while reading bytes from %s: %s", url.toExternalForm(), e.getMessage());
            e.printStackTrace ();
        }
        finally {
            if (is != null) { is.close(); }
        }
        return baos.toByteArray();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        NetworkTileProvider that = (NetworkTileProvider) o;
        return Objects.equals(baseUrl, that.baseUrl) && Objects.equals(headers, that.headers);
    }

    @Override
    public int hashCode() {
        return Objects.hash(baseUrl, headers);
    }
}
