int main() {
    // Triangle vertices (p0, p1, p2)
    float p0x = 0.0f, p0y = 0.0f, p0z = 0.0f;
    float p1x = 1.0f, p1y = 0.0f, p1z = 0.0f;
    float p2x = 0.0f, p2y = 1.0f, p2z = 0.0f;

    // Ray parameters
    float ex = 0.2f, ey = 0.2f, ez = -1.0f;
    float dx = 0.0f, dy = 0.0f, dz = 1.0f;

    // Compute triangle normal
    float e1x = p1x - p0x, e1y = p1y - p0y, e1z = p1z - p0z;
    float e2x = p2x - p0x, e2y = p2y - p0y, e2z = p2z - p0z;
    
    // Cross product
    float nx = e1y*e2z - e1z*e2y;
    float ny = e1z*e2x - e1x*e2z;
    float nz = e1x*e2y - e1y*e2x;

    // Manual square root approximation (Newton-Raphson)
    float len_sq = nx*nx + ny*ny + nz*nz;
    float len = len_sq;
    if (len_sq > 0.0f) {
        for (int i = 0; i < 4; i++) {  // 4 iterations for approximation
            len = 0.5f * (len + len_sq/len);
        }
    }
    nx /= len; ny /= len; nz /= len;

    // Ray-plane intersection
    float denom = dx*nx + dy*ny + dz*nz;
    float abs_denom = denom < 0.0f ? -denom : denom;
    if (abs_denom < 1e-8f) return 0;

    float t = ((p0x-ex)*nx + (p0y-ey)*ny + (p0z-ez)*nz) / denom;
    if (t < 1e-6f) return 0;

    // Intersection point
    float ix = ex + dx*t;
    float iy = ey + dy*t;
    float iz = ez + dz*t;

    // Barycentric coordinates
    float ax = nx < 0.0f ? -nx : nx;
    float ay = ny < 0.0f ? -ny : ny;
    float az = nz < 0.0f ? -nz : nz;
    float u, v, w;

    if (ax >= ay && ax >= az) {  // Project to YZ
        u = (iy-p0y)*(p2z-p0z) - (iz-p0z)*(p2y-p0y);
        v = (iz-p0z)*(p1y-p0y) - (iy-p0y)*(p1z-p0z);
        w = (p1y-p0y)*(p2z-p0z) - (p1z-p0z)*(p2y-p0y);
    } else if (ay >= az) {       // Project to XZ
        u = (ix-p0x)*(p2z-p0z) - (iz-p0z)*(p2x-p0x);
        v = (iz-p0z)*(p1x-p0x) - (ix-p0x)*(p1z-p0z);
        w = (p1x-p0x)*(p2z-p0z) - (p1z-p0z)*(p2x-p0x);
    } else {                     // Project to XY
        u = (ix-p0x)*(p2y-p0y) - (iy-p0y)*(p2x-p0x);
        v = (iy-p0y)*(p1x-p0x) - (ix-p0x)*(p1y-p0y);
        w = (p1x-p0x)*(p2y-p0y) - (p1y-p0y)*(p2x-p0x);
    }

    // Barycentric check
    const float EPS = 1e-6f;
    if (w != 0.0f) {
        u /= w;
        v /= w;
    }

    int inside = (u >= -EPS) && (v >= -EPS) && (u+v <= 1.0f+EPS);

    return inside ? 1 : 0;  // Return 1 if intersection, 0 otherwise
}